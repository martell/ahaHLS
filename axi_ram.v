/*

Copyright (c) 2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1ns / 1ps

/*
 * AXI4 RAM
 */
module axi_ram #
(
    parameter DATA_WIDTH = 32,  // width of data bus in bits
    parameter ADDR_WIDTH = 16,  // width of address bus in bits
    parameter STRB_WIDTH = (DATA_WIDTH/8),
    parameter ID_WIDTH = 8,
    parameter PIPELINE_OUTPUT = 0
)
(
    input wire                   clk,
    input wire                   rst,

    input wire [ID_WIDTH-1:0]    s_axi_awid,
    input wire [ADDR_WIDTH-1:0]  s_axi_awaddr,
    input wire [7:0]             s_axi_awlen,
    input wire [2:0]             s_axi_awsize,
    input wire [1:0]             s_axi_awburst,
    input wire                   s_axi_awlock,
    input wire [3:0]             s_axi_awcache,
    input wire [2:0]             s_axi_awprot,
    input wire                   s_axi_awvalid,
    output wire                  s_axi_awready,
 
    input wire [DATA_WIDTH-1:0]  s_axi_wdata,
    input wire [STRB_WIDTH-1:0]  s_axi_wstrb,
    input wire                   s_axi_wlast,
    input wire                   s_axi_wvalid,
    output wire                  s_axi_wready,
 
    output wire [ID_WIDTH-1:0]   s_axi_bid,
    output wire [1:0]            s_axi_bresp,
    output wire                  s_axi_bvalid,
    input wire                   s_axi_bready,
 
    input wire [ID_WIDTH-1:0]    s_axi_arid,
    input wire [ADDR_WIDTH-1:0]  s_axi_araddr,
    input wire [7:0]             s_axi_arlen,
    input wire [2:0]             s_axi_arsize,
    input wire [1:0]             s_axi_arburst,
    input wire                   s_axi_arlock,
    input wire [3:0]             s_axi_arcache,
    input wire [2:0]             s_axi_arprot,
    input wire                   s_axi_arvalid,
    output wire                  s_axi_arready,
 
    output wire [ID_WIDTH-1:0]   s_axi_rid,
    output wire [DATA_WIDTH-1:0] s_axi_rdata,
    output wire [1:0]            s_axi_rresp,
    output wire                  s_axi_rlast,
    output wire                  s_axi_rvalid,
    input wire                   s_axi_rready
);

parameter VALID_ADDR_WIDTH = ADDR_WIDTH - $clog2(STRB_WIDTH);
parameter WORD_WIDTH = STRB_WIDTH;
parameter WORD_SIZE = DATA_WIDTH/WORD_WIDTH;

// bus width assertions
initial begin
    if (WORD_SIZE * STRB_WIDTH != DATA_WIDTH) begin
        $error("Error: AXI data width not evenly divisble");
        $finish;
    end

    if (2**$clog2(WORD_WIDTH) != WORD_WIDTH) begin
        $error("Error: AXI word width must be even power of two");
        $finish;
    end
end

localparam [0:0]
    READ_STATE_IDLE = 1'd0,
    READ_STATE_BURST = 1'd1;

reg [0:0] read_state_reg = READ_STATE_IDLE, read_state_next;

localparam [0:0]
    WRITE_STATE_IDLE = 1'd0,
    WRITE_STATE_BURST = 1'd1;

reg [0:0] write_state_reg = WRITE_STATE_IDLE, write_state_next;

reg mem_wr_en;
reg mem_rd_en;

reg [ID_WIDTH-1:0] read_id_reg = {ID_WIDTH{1'b0}}, read_id_next;
reg [ADDR_WIDTH-1:0] read_addr_reg = {ADDR_WIDTH{1'b0}}, read_addr_next;
reg read_addr_valid_reg = 1'b0, read_addr_valid_next;
reg read_addr_ready;
reg read_last_reg = 1'b0, read_last_next;
reg [7:0] read_count_reg = 8'd0, read_count_next;
reg [2:0] read_size_reg = 3'd0, read_size_next;
reg [1:0] read_burst_reg = 2'd0, read_burst_next;
reg [ID_WIDTH-1:0] write_id_reg = {ID_WIDTH{1'b0}}, write_id_next;
reg [ADDR_WIDTH-1:0] write_addr_reg = {ADDR_WIDTH{1'b0}}, write_addr_next;
reg write_addr_valid_reg = 1'b0, write_addr_valid_next;
reg write_addr_ready;
reg [7:0] write_count_reg = 8'd0, write_count_next;
reg [2:0] write_size_reg = 3'd0, write_size_next;
reg [1:0] write_burst_reg = 2'd0, write_burst_next;

reg s_axi_awready_reg = 1'b0, s_axi_awready_next;
reg s_axi_wready_reg = 1'b0, s_axi_wready_next;
reg [ID_WIDTH-1:0] s_axi_bid_reg = {ID_WIDTH{1'b0}}, s_axi_bid_next;
reg [1:0] s_axi_bresp_reg = 2'b00, s_axi_bresp_next;
reg s_axi_bvalid_reg = 1'b0, s_axi_bvalid_next;
reg s_axi_arready_reg = 1'b0, s_axi_arready_next;
reg [ID_WIDTH-1:0] s_axi_rid_reg = {ID_WIDTH{1'b0}}, s_axi_rid_next;
reg [DATA_WIDTH-1:0] s_axi_rdata_reg = {DATA_WIDTH{1'b0}}, s_axi_rdata_next;
reg [1:0] s_axi_rresp_reg = 2'b00, s_axi_rresp_next;
reg s_axi_rlast_reg = 1'b0, s_axi_rlast_next;
reg s_axi_rvalid_reg = 1'b0, s_axi_rvalid_next;
reg [ID_WIDTH-1:0] s_axi_rid_pipe_reg = {ID_WIDTH{1'b0}};
reg [DATA_WIDTH-1:0] s_axi_rdata_pipe_reg = {DATA_WIDTH{1'b0}};
reg [1:0] s_axi_rresp_pipe_reg = 2'b00;
reg s_axi_rlast_pipe_reg = 1'b0;
reg s_axi_rvalid_pipe_reg = 1'b0;

// (* RAM_STYLE="BLOCK" *)
reg [DATA_WIDTH-1:0] mem[(2**VALID_ADDR_WIDTH)-1:0];

wire [VALID_ADDR_WIDTH-1:0] s_axi_awaddr_valid = s_axi_awaddr >> (ADDR_WIDTH - VALID_ADDR_WIDTH);
wire [VALID_ADDR_WIDTH-1:0] s_axi_araddr_valid = s_axi_araddr >> (ADDR_WIDTH - VALID_ADDR_WIDTH);
wire [VALID_ADDR_WIDTH-1:0] read_addr_valid = read_addr_reg >> (ADDR_WIDTH - VALID_ADDR_WIDTH);
wire [VALID_ADDR_WIDTH-1:0] write_addr_valid = write_addr_reg >> (ADDR_WIDTH - VALID_ADDR_WIDTH);

assign s_axi_awready = s_axi_awready_reg;
assign s_axi_wready = s_axi_wready_reg;
assign s_axi_bid = s_axi_bid_reg;
assign s_axi_bresp = s_axi_bresp_reg;
assign s_axi_bvalid = s_axi_bvalid_reg;
assign s_axi_arready = s_axi_arready_reg;
assign s_axi_rid = PIPELINE_OUTPUT ? s_axi_rid_pipe_reg : s_axi_rid_reg;
assign s_axi_rdata = PIPELINE_OUTPUT ? s_axi_rdata_pipe_reg : s_axi_rdata_reg;
assign s_axi_rresp = PIPELINE_OUTPUT ? s_axi_rresp_pipe_reg : s_axi_rresp_reg;
assign s_axi_rlast = PIPELINE_OUTPUT ? s_axi_rlast_pipe_reg : s_axi_rlast_reg;
assign s_axi_rvalid = PIPELINE_OUTPUT ? s_axi_rvalid_pipe_reg : s_axi_rvalid_reg;

   // always @(posedge clk) begin
   //    $display("write state = %d", write_state_reg);
   // end

   // always @(posedge clk) begin
   //    $display("read state  = %d", read_state_reg);
   // end
   
integer i, j;

initial begin
    // two nested loops for smaller number of iterations per loop
    // workaround for synthesizer complaints about large loop counts
    for (i = 0; i < 2**ADDR_WIDTH; i = i + 2**(ADDR_WIDTH/2)) begin
        for (j = i; j < i + 2**(ADDR_WIDTH/2); j = j + 1) begin
            mem[j] = 0;
        end
    end
end

   always @(posedge write_state_next or negedge write_state_next) begin
      $display("next write = %d", write_state_next);
      
   end

always @* begin
    write_state_next = WRITE_STATE_IDLE;

    mem_wr_en = 1'b0;

    write_addr_ready = 1'b0;

    if (s_axi_wready & s_axi_wvalid) begin
        write_addr_ready = 1'b1;
        mem_wr_en = 1'b1;
    end

    write_id_next = write_id_reg;
    write_addr_next = write_addr_reg;
    write_addr_valid_next = write_addr_valid_reg && !write_addr_ready;
    write_count_next = write_count_reg;
    write_size_next = write_size_reg;
    write_burst_next = write_burst_reg;

    s_axi_awready_next = 1'b0;
    s_axi_wready_next = write_addr_valid_next;
    s_axi_bid_next = s_axi_bid_reg;
    s_axi_bresp_next = s_axi_bresp_reg;
    s_axi_bvalid_next = s_axi_bvalid_reg && !s_axi_bready;

    case (write_state_reg)
        WRITE_STATE_IDLE: begin
            s_axi_awready_next = (write_addr_ready || !write_addr_valid_reg) && (!s_axi_bvalid || s_axi_bready);

            if (s_axi_awready & s_axi_awvalid) begin
                write_id_next = s_axi_awid;
                write_addr_next = s_axi_awaddr;
                write_count_next = s_axi_awlen;
                write_size_next = s_axi_awsize < $clog2(STRB_WIDTH) ? s_axi_awsize : $clog2(STRB_WIDTH);
                write_burst_next = s_axi_awburst;

                write_addr_valid_next = 1'b1;
                s_axi_wready_next = 1'b1;

               $display("awready and awvalid, awlen = %d", s_axi_awlen);

                if (s_axi_awlen > 0) begin
                   $display("awlen > 0");                   
                    s_axi_awready_next = 1'b0;
                    write_state_next = WRITE_STATE_BURST;
                end else begin
                    s_axi_awready_next = 1'b0;
                    s_axi_bid_next = write_id_next;
                    s_axi_bresp_next = 2'b00;
                    s_axi_bvalid_next = 1'b1;
                    write_state_next = WRITE_STATE_IDLE;
                end
            end else begin
                write_state_next = WRITE_STATE_IDLE;
            end
        end
        WRITE_STATE_BURST: begin
            s_axi_awready_next = 1'b0;

            if (write_addr_ready) begin
                if (write_burst_reg != 2'b00) begin
                    write_addr_next = write_addr_reg + (1 << write_size_reg);
                end
                write_count_next = write_count_reg - 1;
                s_axi_wready_next = 1'b1;

               $display("write_count_reg = %d", write_count_reg);
               
                if (write_count_reg > 0) begin
                    write_addr_valid_next = 1'b1;

                   $display("write burst again, count = %d", write_count_reg);     
                    write_state_next = WRITE_STATE_BURST;
                end else begin
                    write_addr_valid_next = 1'b0;
                    s_axi_awready_next = 1'b0;
                    s_axi_wready_next = 1'b0;
                    s_axi_bid_next = write_id_reg;
                    s_axi_bresp_next = 2'b00;
                    s_axi_bvalid_next = 1'b1;

                   $display("write now idle, awready = %d, wvalid = %d, wready = %d", s_axi_awready, s_axi_wvalid, s_axi_wready);
                   
                    write_state_next = WRITE_STATE_IDLE;
                end
            end else begin // if (write_addr_ready)

               $display("write addr not ready, awvalid = %d, awready = %d, wvalid = %d, wready = %d", s_axi_awvalid, s_axi_awready, s_axi_wvalid, s_axi_wready);
                write_state_next = WRITE_STATE_BURST;
            end
        end
    endcase
end

always @(posedge clk) begin
    if (rst) begin
        write_state_reg <= WRITE_STATE_IDLE;
        write_addr_valid_reg <= 1'b0;
        s_axi_awready_reg <= 1'b0;
        s_axi_wready_reg <= 1'b0;
        s_axi_bvalid_reg <= 1'b0;
    end else begin
       //$display("write_state_next = %d", write_state_next);
       
        write_state_reg <= write_state_next;
        write_addr_valid_reg <= write_addr_valid_next;
        s_axi_awready_reg <= s_axi_awready_next;
        s_axi_wready_reg <= s_axi_wready_next;
        s_axi_bvalid_reg <= s_axi_bvalid_next;
    end

    write_id_reg <= write_id_next;
    write_addr_reg <= write_addr_next;
    write_count_reg <= write_count_next;
    write_size_reg <= write_size_next;
    write_burst_reg <= write_burst_next;

    s_axi_bid_reg <= s_axi_bid_next;
    s_axi_bresp_reg <= s_axi_bresp_next;

    for (i = 0; i < WORD_WIDTH; i = i + 1) begin
        if (mem_wr_en & s_axi_wstrb[i]) begin
           $display("writing data %d to %d", s_axi_wdata, write_addr_valid);
           
            mem[write_addr_valid][8*i +: 8] <= s_axi_wdata[8*i +: 8];
        end
    end
end

always @* begin
    read_state_next = READ_STATE_IDLE;

    mem_rd_en = 1'b0;

    read_addr_ready = (s_axi_rready || (PIPELINE_OUTPUT && !s_axi_rvalid_pipe_reg));

    s_axi_rid_next = s_axi_rid_reg;
    s_axi_rresp_next = s_axi_rresp_reg;
    s_axi_rlast_next = s_axi_rlast_reg;
    s_axi_rvalid_next = s_axi_rvalid_reg && !(s_axi_rready || (PIPELINE_OUTPUT && !s_axi_rvalid_pipe_reg));

    if (read_addr_valid_reg && (s_axi_rready || (PIPELINE_OUTPUT && !s_axi_rvalid_pipe_reg) || !s_axi_rvalid)) begin
        read_addr_ready = 1'b1;
        mem_rd_en = 1'b1;
        s_axi_rvalid_next = 1'b1;
        s_axi_rid_next = read_id_reg;
        s_axi_rlast_next = read_last_reg;
    end

    read_id_next = read_id_reg;
    read_addr_next = read_addr_reg;
    read_addr_valid_next = read_addr_valid_reg && !read_addr_ready;
    read_last_next = read_last_reg;
    read_count_next = read_count_reg;
    read_size_next = read_size_reg;
    read_burst_next = read_burst_reg;

    s_axi_arready_next = 1'b0;

    case (read_state_reg)
        READ_STATE_IDLE: begin
            s_axi_arready_next = (read_addr_ready || !read_addr_valid_reg);

            if (s_axi_arready & s_axi_arvalid) begin
                read_id_next = s_axi_arid;
                read_addr_next = s_axi_araddr;
                read_count_next = s_axi_arlen;
                read_size_next = s_axi_arsize < $clog2(STRB_WIDTH) ? s_axi_arsize : $clog2(STRB_WIDTH);
                read_burst_next = s_axi_arburst;

                read_addr_valid_next = 1'b1;
                if (s_axi_arlen > 0) begin
                    s_axi_arready_next = 1'b0;
                    read_last_next = 1'b0;
                    read_state_next = READ_STATE_BURST;
                end else begin
                    s_axi_arready_next = 1'b0;
                    read_last_next = 1'b1;
                    read_state_next = READ_STATE_IDLE;
                end
            end else begin
                read_state_next = READ_STATE_IDLE;
            end
        end
        READ_STATE_BURST: begin
            s_axi_arready_next = 1'b0;

            if (read_addr_ready) begin
                if (read_burst_reg != 2'b00) begin
                    read_addr_next = read_addr_reg + (1 << read_size_reg);
                end
                read_count_next = read_count_reg - 1;
                read_last_next = read_count_next == 0;
                if (read_count_reg > 0) begin
                    read_addr_valid_next = 1'b1;
                    read_state_next = READ_STATE_BURST;
                end else begin
                    s_axi_arready_next = 1'b0;
                    read_addr_valid_next = 1'b0;
                    read_state_next = READ_STATE_IDLE;
                end
            end else begin
                read_state_next = READ_STATE_BURST;
            end
        end
    endcase
end

always @(posedge clk) begin
    if (rst) begin
        read_state_reg <= READ_STATE_IDLE;
        read_addr_valid_reg <= 1'b0;
        s_axi_arready_reg <= 1'b0;
        s_axi_rvalid_reg <= 1'b0;
        s_axi_rvalid_pipe_reg <= 1'b0;
    end else begin
        read_state_reg <= read_state_next;
        read_addr_valid_reg <= read_addr_valid_next;
        s_axi_arready_reg <= s_axi_arready_next;
        s_axi_rvalid_reg <= s_axi_rvalid_next;

        if (!s_axi_rvalid_pipe_reg || s_axi_rready) begin
            s_axi_rvalid_pipe_reg <= s_axi_rvalid_reg;
        end
    end

    read_id_reg <= read_id_next;
    read_addr_reg <= read_addr_next;
    read_last_reg <= read_last_next;
    read_count_reg <= read_count_next;
    read_size_reg <= read_size_next;
    read_burst_reg <= read_burst_next;

    s_axi_rid_reg <= s_axi_rid_next;
    s_axi_rresp_reg <= s_axi_rresp_next;
    s_axi_rlast_reg <= s_axi_rlast_next;

    if (mem_rd_en) begin
       $display("reading %d from addr %d", mem[read_addr_valid], read_addr_valid);
       
        s_axi_rdata_reg <= mem[read_addr_valid];
    end

    if (!s_axi_rvalid_pipe_reg || s_axi_rready) begin
        s_axi_rid_pipe_reg <= s_axi_rid_reg;
        s_axi_rdata_pipe_reg <= s_axi_rdata_reg;
        s_axi_rresp_pipe_reg <= s_axi_rresp_reg;
        s_axi_rlast_pipe_reg <= s_axi_rlast_reg;
    end
end

endmodule
