module write_header_func_inner(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [0:0] arg_3_m_axis_tready, output [47:0] arg_3_s_eth_dest_mac, output [0:0] arg_3_s_eth_hdr_valid, output [7:0] arg_3_s_eth_payload_axis_tdata, output [0:0] arg_3_s_eth_payload_axis_tlast, output [0:0] arg_3_s_eth_payload_axis_tuser, output [0:0] arg_3_s_eth_payload_axis_tvalid, output [47:0] arg_3_s_eth_src_mac, output [15:0] arg_3_s_eth_type, input [0:0] arg_3_busy, input [0:0] arg_3_s_eth_hdr_ready, input [0:0] arg_3_s_eth_payload_axis_tready, input [47:0] arg_0_out_data, input [47:0] arg_1_out_data, input [15:0] arg_2_out_data);

	reg [0:0] valid_reg;
	reg [0:0] arg_3_m_axis_tready_reg;
	reg [47:0] arg_3_s_eth_dest_mac_reg;
	reg [0:0] arg_3_s_eth_hdr_valid_reg;
	reg [7:0] arg_3_s_eth_payload_axis_tdata_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tlast_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tuser_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tvalid_reg;
	reg [47:0] arg_3_s_eth_src_mac_reg;
	reg [15:0] arg_3_s_eth_type_reg;

	assign valid = valid_reg;
	assign arg_3_m_axis_tready = arg_3_m_axis_tready_reg;
	assign arg_3_s_eth_dest_mac = arg_3_s_eth_dest_mac_reg;
	assign arg_3_s_eth_hdr_valid = arg_3_s_eth_hdr_valid_reg;
	assign arg_3_s_eth_payload_axis_tdata = arg_3_s_eth_payload_axis_tdata_reg;
	assign arg_3_s_eth_payload_axis_tlast = arg_3_s_eth_payload_axis_tlast_reg;
	assign arg_3_s_eth_payload_axis_tuser = arg_3_s_eth_payload_axis_tuser_reg;
	assign arg_3_s_eth_payload_axis_tvalid = arg_3_s_eth_payload_axis_tvalid_reg;
	assign arg_3_s_eth_src_mac = arg_3_s_eth_src_mac_reg;
	assign arg_3_s_eth_type = arg_3_s_eth_type_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add alloca_0();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [47:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [47:0] rdata_ram_0;
	reg_passthrough #(.WIDTH(48)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	reg [31:0] raddr_ram_1_reg;
	reg [31:0] waddr_ram_1_reg;
	reg [47:0] wdata_ram_1_reg;
	reg [0:0] wen_ram_1_reg;
	wire [47:0] rdata_ram_1;
	reg_passthrough #(.WIDTH(48)) ram_1(.clk(clk), .raddr(raddr_ram_1_reg), .rdata(rdata_ram_1), .rst(rst), .waddr(waddr_ram_1_reg), .wdata(wdata_ram_1_reg), .wen(wen_ram_1_reg));

	reg [31:0] raddr_ram_2_reg;
	reg [31:0] waddr_ram_2_reg;
	reg [15:0] wdata_ram_2_reg;
	reg [0:0] wen_ram_2_reg;
	wire [15:0] rdata_ram_2;
	reg_passthrough #(.WIDTH(16)) ram_2(.clk(clk), .raddr(raddr_ram_2_reg), .rdata(rdata_ram_2), .rst(rst), .waddr(waddr_ram_2_reg), .wdata(wdata_ram_2_reg), .wen(wen_ram_2_reg));

	add alloca_4();

	add alloca_6();

	add alloca_9();

	reg [31:0] raddr_ram_6_reg;
	reg [31:0] waddr_ram_6_reg;
	reg [47:0] wdata_ram_6_reg;
	reg [0:0] wen_ram_6_reg;
	wire [47:0] rdata_ram_6;
	reg_passthrough #(.WIDTH(48)) ram_6(.clk(clk), .raddr(raddr_ram_6_reg), .rdata(rdata_ram_6), .rst(rst), .waddr(waddr_ram_6_reg), .wdata(wdata_ram_6_reg), .wen(wen_ram_6_reg));

	add alloca_11();

	reg [31:0] raddr_ram_7_reg;
	reg [31:0] waddr_ram_7_reg;
	reg [15:0] wdata_ram_7_reg;
	reg [0:0] wen_ram_7_reg;
	wire [15:0] rdata_ram_7;
	reg_passthrough #(.WIDTH(16)) ram_7(.clk(clk), .raddr(raddr_ram_7_reg), .rdata(rdata_ram_7), .rst(rst), .waddr(waddr_ram_7_reg), .wdata(wdata_ram_7_reg), .wen(wen_ram_7_reg));

	add alloca_13();

	reg [31:0] raddr_ram_8_reg;
	reg [31:0] waddr_ram_8_reg;
	reg [47:0] wdata_ram_8_reg;
	reg [0:0] wen_ram_8_reg;
	wire [47:0] rdata_ram_8;
	reg_passthrough #(.WIDTH(48)) ram_8(.clk(clk), .raddr(raddr_ram_8_reg), .rdata(rdata_ram_8), .rst(rst), .waddr(waddr_ram_8_reg), .wdata(wdata_ram_8_reg), .wen(wen_ram_8_reg));

	add call_16();

	// End Functional Units

	// Start instruction result storage
	reg [47:0] load_tmp_4;
	reg [47:0] load_tmp_5;
	reg [15:0] load_tmp_6;
	// End instruction result storage

	// Start pipeline variables
	// End pipeline variables

	reg [31:0] global_state;
	reg [31:0] last_BB_reg;
	// Start pipeline reset block
	always @(posedge clk) begin
		if (rst) begin
		end
	end
	// End pipeline reset block

	// Start pipeline valid chain block
	always @(posedge clk) begin

		if (!rst) begin
		end
	end
	// End pipeline valid chain block

	always @(posedge clk) begin
	end
	// Start pipeline initiation block
	always @(posedge clk) begin
	end
	// End pipeline initiation block

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if ((global_state == 0)) begin
			end
			if ((global_state == 1)) begin
					last_BB_reg <= 0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			// Control code
			if ((global_state == 0)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
				if (arg_3_s_eth_hdr_ready) begin 
					global_state <= 1;
				end
				end
			end
			if ((global_state == 1)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 1;
				end
			end

			// Temporary storage code
			if ((global_state == 0)) begin 
				// Temporary storage
				if (arg_3_s_eth_hdr_ready) begin
				// Store data computed at the stage
					load_tmp_4 <= rdata_ram_8;
					load_tmp_5 <= rdata_ram_6;
					load_tmp_6 <= rdata_ram_7;
				end
			end
			if ((global_state == 1)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %0 = alloca i48
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i48 %arg_0, i48* %0
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_0_reg = 0;
				wdata_ram_0_reg = arg_0_out_data;
				wen_ram_0_reg = 1;
				end
				//   %3 = load i48, i48* %0
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_0_reg = 0;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %4 = load i48, i48* %1
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_1_reg = 0;
				end
				//   store i48 %arg_1, i48* %1
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_1_reg = 0;
				wdata_ram_1_reg = arg_1_out_data;
				wen_ram_1_reg = 1;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %5 = load i16, i16* %2
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_2_reg = 0;
				end
				//   store i16 %arg_2, i16* %2
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_2_reg = 0;
				wdata_ram_2_reg = arg_2_out_data;
				wen_ram_2_reg = 1;
				end
		end else begin 
			// Default values
		end
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %1 = alloca i48
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %2 = alloca i16
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %7 = alloca i48
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i48 %4, i48* %7
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_6_reg = 0;
				wdata_ram_6_reg = rdata_ram_1;
				wen_ram_6_reg = 1;
				end
				//   %11 = load i48, i48* %7
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_6_reg = 0;
				end
		end else begin 
			// Default values
		end
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %8 = alloca i16
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i16 %5, i16* %8
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_7_reg = 0;
				wdata_ram_7_reg = rdata_ram_2;
				wen_ram_7_reg = 1;
				end
				//   %12 = load i16, i16* %8
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_7_reg = 0;
				end
		end else begin 
			// Default values
		end
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %6 = alloca i48
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i48 %3, i48* %6
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_8_reg = 0;
				wdata_ram_8_reg = rdata_ram_0;
				wen_ram_8_reg = 1;
				end
				//   %10 = load i48, i48* %6
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_8_reg = 0;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %9 = call i1 @builtin_read_port_s_eth_hdr_ready(%eth_axis_tx* %arg_3)
				if (arg_3_s_eth_hdr_ready) begin
				end
			arg_3_s_eth_dest_mac_reg = 0;
			arg_3_s_eth_hdr_valid_reg = 0;
			arg_3_s_eth_payload_axis_tdata_reg = 0;
			arg_3_s_eth_payload_axis_tlast_reg = 0;
			arg_3_s_eth_payload_axis_tuser_reg = 0;
			arg_3_s_eth_payload_axis_tvalid_reg = 0;
			arg_3_s_eth_src_mac_reg = 0;
			arg_3_s_eth_type_reg = 0;
		end else 		if ((global_state == 1)) begin 
				//   call void @builtin_write_port_s_eth_hdr_valid(%eth_axis_tx* %arg_3, i32 1)
				arg_3_s_eth_hdr_valid_reg = (32'd1);
				//   call void @builtin_write_port_s_eth_dest_mac(%eth_axis_tx* %arg_3, i48 %10)
				arg_3_s_eth_dest_mac_reg = load_tmp_4;
				//   call void @builtin_write_port_s_eth_src_mac(%eth_axis_tx* %arg_3, i48 %11)
				arg_3_s_eth_src_mac_reg = load_tmp_5;
				//   call void @builtin_write_port_s_eth_type(%eth_axis_tx* %arg_3, i16 %12)
				arg_3_s_eth_type_reg = load_tmp_6;
			arg_3_s_eth_payload_axis_tdata_reg = 0;
			arg_3_s_eth_payload_axis_tlast_reg = 0;
			arg_3_s_eth_payload_axis_tuser_reg = 0;
			arg_3_s_eth_payload_axis_tvalid_reg = 0;
		end else begin 
			// Default values
				arg_3_s_eth_dest_mac_reg = 0;
				arg_3_s_eth_hdr_valid_reg = 0;
				arg_3_s_eth_payload_axis_tdata_reg = 0;
				arg_3_s_eth_payload_axis_tlast_reg = 0;
				arg_3_s_eth_payload_axis_tuser_reg = 0;
				arg_3_s_eth_payload_axis_tvalid_reg = 0;
				arg_3_s_eth_src_mac_reg = 0;
				arg_3_s_eth_type_reg = 0;
		end
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   call void @builtin_stall(i1 %9)
	end
	always @(*) begin
		if ((global_state == 1)) begin 
				//   ret void
				valid_reg = 1;
		end else begin 
			// Default values
				valid_reg = 0;
		end
	end
endmodule

module write_header_func(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [0:0] arg_3_m_axis_tready, output [47:0] arg_3_s_eth_dest_mac, output [0:0] arg_3_s_eth_hdr_valid, output [7:0] arg_3_s_eth_payload_axis_tdata, output [0:0] arg_3_s_eth_payload_axis_tlast, output [0:0] arg_3_s_eth_payload_axis_tuser, output [0:0] arg_3_s_eth_payload_axis_tvalid, output [47:0] arg_3_s_eth_src_mac, output [15:0] arg_3_s_eth_type, input [0:0] arg_3_busy, input [0:0] arg_3_s_eth_hdr_ready, input [0:0] arg_3_s_eth_payload_axis_tready, input [47:0] arg_0_out_data, input [47:0] arg_1_out_data, input [15:0] arg_2_out_data);


	initial begin
	end




	write_header_func_inner inner(.arg_0_out_data(arg_0_out_data), .arg_1_out_data(arg_1_out_data), .arg_2_out_data(arg_2_out_data), .arg_3_busy(arg_3_busy), .arg_3_m_axis_tready(arg_3_m_axis_tready), .arg_3_s_eth_dest_mac(arg_3_s_eth_dest_mac), .arg_3_s_eth_hdr_ready(arg_3_s_eth_hdr_ready), .arg_3_s_eth_hdr_valid(arg_3_s_eth_hdr_valid), .arg_3_s_eth_payload_axis_tdata(arg_3_s_eth_payload_axis_tdata), .arg_3_s_eth_payload_axis_tlast(arg_3_s_eth_payload_axis_tlast), .arg_3_s_eth_payload_axis_tready(arg_3_s_eth_payload_axis_tready), .arg_3_s_eth_payload_axis_tuser(arg_3_s_eth_payload_axis_tuser), .arg_3_s_eth_payload_axis_tvalid(arg_3_s_eth_payload_axis_tvalid), .arg_3_s_eth_src_mac(arg_3_s_eth_src_mac), .arg_3_s_eth_type(arg_3_s_eth_type), .clk(clk), .rst(rst), .valid(valid));

endmodule