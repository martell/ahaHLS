module vhls_target_tb();
	reg [31:0] num_clocks_after_reset;
	reg [31:0] total_cycles;
	reg [31:0] max_cycles;
	reg [0:0] clk_reg;
	reg [0:0] rst_reg;
	wire [0:0] clk;
	wire [0:0] rst;
	reg [15:0] arg_0_in_data;
	wire [15:0] arg_0_out_data;
	wire [0:0] arg_0_read_ready;
	wire [0:0] arg_0_read_valid;
	wire [0:0] arg_0_write_ready;
	reg [0:0] arg_0_write_valid;
	wire [15:0] arg_1_in_data;
	wire [15:0] arg_1_out_data;
	wire [0:0] arg_1_read_ready;
	reg [0:0] arg_1_read_valid;
	wire [0:0] arg_1_write_ready;
	wire [0:0] arg_1_write_valid;

	initial begin
		#1 clk_reg = 0;
		#1 rst_reg = 1;
		#1 total_cycles = 0;
		#1 max_cycles = 1000;
		#1 num_clocks_after_reset = 0;
	end

	assign clk = clk_reg;
	assign rst = rst_reg;

	always @(posedge clk) begin
		if (1 == total_cycles) begin rst_reg <= 0; end
	end

	always @(posedge clk) begin
		if (700 == total_cycles) begin if (!(valid === 1)) begin $display("assertion(valid === 1)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (703 == total_cycles) begin if (!(arg_1_out_data === 16'd56)) begin $display("assertion(arg_1_out_data === 16'd56)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (705 == total_cycles) begin if (!(arg_1_out_data === 16'd20)) begin $display("assertion(arg_1_out_data === 16'd20)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (707 == total_cycles) begin if (!(arg_1_out_data === 16'd14)) begin $display("assertion(arg_1_out_data === 16'd14)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (709 == total_cycles) begin if (!(arg_1_out_data === 16'd6)) begin $display("assertion(arg_1_out_data === 16'd6)"); $finish(); end end
	end

	always @(*) begin
		if (0 == total_cycles) begin arg_1_read_valid = 1'b0; end
	end

	always @(*) begin
		if (0 == total_cycles) begin arg_0_write_valid = 1'b0; end
	end

	always @(*) begin
		if (2 == total_cycles) begin arg_0_in_data = 16'd28; end
	end

	always @(*) begin
		if (2 == total_cycles) begin arg_0_write_valid = 1'b1; end
	end

	always @(*) begin
		if (3 == total_cycles) begin arg_0_in_data = 16'd10; end
	end

	always @(*) begin
		if (3 == total_cycles) begin arg_0_write_valid = 1'b1; end
	end

	always @(*) begin
		if (4 == total_cycles) begin arg_0_in_data = 16'd7; end
	end

	always @(*) begin
		if (4 == total_cycles) begin arg_0_write_valid = 1'b1; end
	end

	always @(*) begin
		if (5 == total_cycles) begin arg_0_in_data = 16'd3; end
	end

	always @(*) begin
		if (5 == total_cycles) begin arg_0_write_valid = 1'b1; end
	end

	always @(*) begin
		if (6 == total_cycles) begin arg_0_write_valid = 1'b0; end
	end

	always @(*) begin
		if (7 == total_cycles) begin arg_0_in_data = 16'd9; end
	end

	always @(*) begin
		if (7 == total_cycles) begin arg_0_write_valid = 1'b1; end
	end

	always @(*) begin
		if (8 == total_cycles) begin arg_0_write_valid = 1'b0; end
	end

	always @(*) begin
		if (702 == total_cycles) begin arg_1_read_valid = 1'b1; end
	end

	always @(*) begin
		if (703 == total_cycles) begin arg_1_read_valid = 1'b0; end
	end

	always @(*) begin
		if (704 == total_cycles) begin arg_1_read_valid = 1'b1; end
	end

	always @(*) begin
		if (705 == total_cycles) begin arg_1_read_valid = 1'b0; end
	end

	always @(*) begin
		if (706 == total_cycles) begin arg_1_read_valid = 1'b1; end
	end

	always @(*) begin
		if (707 == total_cycles) begin arg_1_read_valid = 1'b0; end
	end

	always @(*) begin
		if (708 == total_cycles) begin arg_1_read_valid = 1'b1; end
	end

	always @(*) begin
		if (709 == total_cycles) begin arg_1_read_valid = 1'b0; end
	end

	always @(posedge clk) begin
		total_cycles <= total_cycles + 1;
	end

	always @(posedge clk) begin
		if (total_cycles >= max_cycles) begin $display("Passed"); $finish(); end
	end


	always #3 begin
		clk_reg = !clk_reg;
	end


	fifo #(.DEPTH(128), .WIDTH(16)) arg_0(.clk(clk), .in_data(arg_0_in_data), .out_data(arg_0_out_data), .read_ready(arg_0_read_ready), .read_valid(arg_0_read_valid), .rst(rst), .write_ready(arg_0_write_ready), .write_valid(arg_0_write_valid));

	fifo #(.DEPTH(128), .WIDTH(16)) arg_1(.clk(clk), .in_data(arg_1_in_data), .out_data(arg_1_out_data), .read_ready(arg_1_read_ready), .read_valid(arg_1_read_valid), .rst(rst), .write_ready(arg_1_write_ready), .write_valid(arg_1_write_valid));

	vhls_target dut(.arg_0_out_data(arg_0_out_data), .arg_0_read_ready(arg_0_read_ready), .arg_0_read_valid(arg_0_read_valid), .arg_0_write_ready(arg_0_write_ready), .arg_1_in_data(arg_1_in_data), .arg_1_out_data(arg_1_out_data), .arg_1_read_ready(arg_1_read_ready), .arg_1_write_ready(arg_1_write_ready), .arg_1_write_valid(arg_1_write_valid), .clk(clk), .rst(rst), .valid(valid));

endmodule
