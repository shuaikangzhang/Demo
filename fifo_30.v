
module fifo_30 (

    input wire         rst_n      , 
    input wire         rdclk      ,
    input wire         wrclk      ,

    output reg        data_valid ,
    output reg [63:0] up_data

);

    //定义fifo内部连接信号
    reg             wrreq     [1:30]  ;
    reg    [31:0]   data      [1:30]  ;
    reg             rdreq     [1:30]  ;
    wire   [63:0]   q         [1:30]  ;
    wire   [9:0]    rdusedw   [1:30]  ;
    
    //定义计数器
    reg [31:0] cnt_wr [1:30]    ;

    genvar j;
    generate
        for (j = 1;j <= 30 ;j = j + 1 ) 
            begin:jjj

                //计数器
                always @(posedge wrclk or negedge rst_n) begin
                    if(!rst_n) 
                        begin
                            cnt_wr[j][31:0] <= 32'd0;
                        end
                    else if(cnt_wr[j][31:0] == (32'd1 + j))
                        begin
                            cnt_wr[j][31:0] <= 32'd0;
                        end
                    else
                        begin
                            cnt_wr[j][31:0] <=cnt_wr[j][31:0] + 32'd1;
                        end
                end 

                //fifo写请求信号拉高
                always @(posedge wrclk or negedge rst_n) begin
                    if(!rst_n) 
                        begin
                            wrreq[j] <= 1'b0;
                        end
                    else if(cnt_wr[j][31:0] == (32'd1 + j))
                        begin
                            wrreq[j] <= 1'b1;
                        end
                    else 
                        begin
                            wrreq[j] <= 1'b0;
                        end
                end

                //fifo写数据
                always @(posedge wrclk or negedge rst_n) begin
                    if(!rst_n) 
                        begin
                            data[j][31:0] <= 32'd0;
                        end
                    else if(cnt_wr[j][31:0] == (32'd1 + j))
                        begin
                            data[j][31:0] <= data[j][31:0] + 32'd1;
                        end
                    else 
                        begin
                            data[j][31:0] <= data[j][31:0];
                        end
                end
            end
    endgenerate

    //定义参数
    parameter XINGHAO = 32'hadf90c00;
    parameter YUZHI = 1024;
    parameter YUZHI_POINT = YUZHI>>2'd3;

    parameter IDLE = 8'd0;
    parameter S0 = 8'd1;
    parameter S1 = 8'd2;
    parameter S2 = 8'd3;
    parameter S3 = 8'd4;
    parameter S4 = 8'd5;
    parameter S5 = 8'd6;
    parameter S6 = 8'd7;
    parameter S7 = 8'd8;
    parameter S8 = 8'd9;
    parameter S9 = 8'd10;
    parameter S10 = 8'd11;

    parameter S11 = 8'd12;
    parameter S12 = 8'd13;
    parameter S13 = 8'd14;
    parameter S14 = 8'd15;
    parameter S15 = 8'd16;
    parameter S16 = 8'd17;
    parameter S17 = 8'd18;
    parameter S18 = 8'd19;
    parameter S19 = 8'd20;
    parameter S20 = 8'd21;

    parameter S21 = 8'd22;
    parameter S22 = 8'd23;
    parameter S23 = 8'd24;
    parameter S24 = 8'd25;
    parameter S25 = 8'd26;
    parameter S26 = 8'd27;
    parameter S27 = 8'd28;
    parameter S28 = 8'd29;
    parameter S29 = 8'd30;
    parameter S30 = 8'd31;

    parameter S31 = 8'd32;
    parameter S32 = 8'd33;
    parameter S33 = 8'd34;
    parameter S34 = 8'd35;
    parameter S35 = 8'd36;
    parameter S36 = 8'd37;
    parameter S37 = 8'd38;
    parameter S38 = 8'd39;
    parameter S39 = 8'd40;
    parameter S40 = 8'd41;

    parameter S41 = 8'd42;
    parameter S42 = 8'd43;
    parameter S43 = 8'd44;
    parameter S44 = 8'd45;
    parameter S45 = 8'd46;
    parameter S46 = 8'd47;
    parameter S47 = 8'd48;
    parameter S48 = 8'd49;
    parameter S49 = 8'd50;
    parameter S50 = 8'd51;

    parameter S51 = 8'd52;
    parameter S52 = 8'd53;
    parameter S53 = 8'd54;
    parameter S54 = 8'd55;
    parameter S55 = 8'd56;
    parameter S56 = 8'd57;
    parameter S57 = 8'd58;  
    parameter S58 = 8'd59;
    parameter S59 = 8'd60;
    parameter S60 = 8'd61;

    reg [7:0] state;

    reg [31:0] cnt;

    reg [31:0] cnt_fifo;
 
    reg  rdreq_r1        [1:30] ;
    reg  rdreq_r2        [1:30] ;
    wire rdreq_fall_edge [1:30] ;

    reg [63:0] cnt_fifo_send_packet [1:30] ;


    //检测输出数据来自哪个fifo
    always @(posedge rdclk or negedge rst_n) begin
        if(!rst_n) 
            begin
                cnt_fifo[31:0] <= 32'd0;
            end
        else if(state == S1)
            begin
                cnt_fifo[31:0] <= 32'd1;
            end
        else if(state == S3)
            begin
                cnt_fifo[31:0] <= 32'd2;
            end
        else if(state == S5)
            begin
                cnt_fifo[31:0] <= 32'd3;
            end
        else if(state == S7)
            begin
                cnt_fifo[31:0] <= 32'd4;
            end
        else if(state == S9)
            begin
                cnt_fifo[31:0] <= 32'd5;
            end
        else if(state == S11)
            begin
                cnt_fifo[31:0] <= 32'd6;
            end
        else if(state == S13)
            begin
                cnt_fifo[31:0] <= 32'd7;
            end
        else if(state == S15)
            begin
                cnt_fifo[31:0] <= 32'd8;
            end
        else if(state == S17)
            begin
                cnt_fifo[31:0] <= 32'd9;
            end
        else if(state == S19)
            begin
                cnt_fifo[31:0] <= 32'd10;
            end
        else if(state == S21)
            begin
                cnt_fifo[31:0] <= 32'd11;
            end
        else if(state == S23)
            begin
                cnt_fifo[31:0] <= 32'd12;
            end
        else if(state == S25)
            begin
                cnt_fifo[31:0] <= 32'd13;
            end
        else if(state == S27)
            begin
                cnt_fifo[31:0] <= 32'd14;
            end
        else if(state == S29)
            begin
                cnt_fifo[31:0] <= 32'd15;
            end
        else if(state == S31)
            begin
                cnt_fifo[31:0] <= 32'd16;
            end
        else if(state == S33)
            begin
                cnt_fifo[31:0] <= 32'd17;
            end
        else if(state == S35)
            begin
                cnt_fifo[31:0] <= 32'd18;
            end
        else if(state == S37)
            begin
                cnt_fifo[31:0] <= 32'd19;
            end
        else if(state == S39)
            begin
                cnt_fifo[31:0] <= 32'd20;
            end
        else if(state == S41)
            begin
                cnt_fifo[31:0] <= 32'd21;
            end
        else if(state == S43)
            begin
                cnt_fifo[31:0] <= 32'd22;
            end
        else if(state == S45)
            begin
                cnt_fifo[31:0] <= 32'd23;
            end
        else if(state == S47)
            begin
                cnt_fifo[31:0] <= 32'd24;
            end
        else if(state == S49)
            begin
                cnt_fifo[31:0] <= 32'd25;
            end
        else if(state == S51)
            begin
                cnt_fifo[31:0] <= 32'd26;
            end
        else if(state == S53)
            begin
                cnt_fifo[31:0] <= 32'd27;
            end
        else if(state == S55)
            begin
                cnt_fifo[31:0] <= 32'd28;
            end
        else if(state == S57)
            begin
                cnt_fifo[31:0] <= 32'd29;
            end
        else if(state == S59)
            begin
                cnt_fifo[31:0] <= 32'd30;
            end
        else
            begin
                cnt_fifo[31:0] <= 32'd0;
            end
    end

    //检测rdreq读请求信号下降沿
    genvar k;
    generate
        for (k = 1;k <= 30 ;k = k + 1 ) 
            begin:kkk
                always @(posedge rdclk or negedge rst_n) begin
                    if(!rst_n) 
                        begin
                            rdreq_r1[k] <= 1'b0;
                            rdreq_r2[k] <= 1'b0;
                        end
                    else
                        begin
                            rdreq_r1[k] <= rdreq[k];
                            rdreq_r2[k] <= rdreq_r1[k];
                        end
                end

                assign rdreq_fall_edge[k] = (rdreq_r1[k] == 1'b0) && (rdreq_r2[k] == 1'b1);

                //统计每个fifo发送数据包个数
		        always @ (posedge rdclk or negedge rst_n)
		        begin 
		        	if(!rst_n)
		        		begin 
		        			cnt_fifo_send_packet[k][63:0] <= 64'd0;
		        		end 
		        	else if(rdreq_fall_edge[k])
		        		begin 
		        			cnt_fifo_send_packet[k][63:0] <= cnt_fifo_send_packet[k][63:0] + 64'd1;
		        		end 
		        end
            end
    endgenerate

    //轮询检测fifo状态跳转
    always @(posedge rdclk or negedge rst_n) begin
        if(!rst_n)
            begin
                cnt[31:0] <= 32'd0;
                state <=IDLE;
                rdreq[1] <= 1'b0;
                rdreq[2] <= 1'b0;
                rdreq[3] <= 1'b0;
                rdreq[4] <= 1'b0;
                rdreq[5] <= 1'b0;
                rdreq[6] <= 1'b0;
                rdreq[7] <= 1'b0;
                rdreq[8] <= 1'b0;
                rdreq[9] <= 1'b0;
                rdreq[10] <= 1'b0;
                rdreq[11] <= 1'b0;
                rdreq[12] <= 1'b0;
                rdreq[13] <= 1'b0;
                rdreq[14] <= 1'b0;
                rdreq[15] <= 1'b0;
                rdreq[16] <= 1'b0;
                rdreq[17] <= 1'b0;
                rdreq[18] <= 1'b0;
                rdreq[19] <= 1'b0;
                rdreq[20] <= 1'b0;
                rdreq[21] <= 1'b0;
                rdreq[22] <= 1'b0;
                rdreq[23] <= 1'b0;
                rdreq[24] <= 1'b0;
                rdreq[25] <= 1'b0;
                rdreq[26] <= 1'b0;
                rdreq[27] <= 1'b0;
                rdreq[28] <= 1'b0;
                rdreq[29] <= 1'b0;
                rdreq[30] <= 1'b0;
                data_valid <= 1'b0;
            end
        else
            begin
                case (state)
                        IDLE: 
                            begin
                                cnt[31:0] <= 32'd0;
                                data_valid <= 1'b0;
                                state <= S0;
                            end
                        S0: 
                            begin
                                if(rdusedw[1] >= YUZHI_POINT)
                                    begin
                                        state <= S1;
                                    end
                                else
                                    begin
                                        state <= S2;
                                    end
                            end
                        S1: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S2;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[1] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[1] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end
                        S2: 
                            begin
                                if(rdusedw[2] >= YUZHI_POINT)
                                    begin
                                        state <= S3;
                                    end
                                else
                                    begin
                                        state <= S4;
                                    end
                            end
                        S3: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S4;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[2] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[2] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end    

                        S4: 
                            begin
                                if(rdusedw[3] >= YUZHI_POINT)
                                    begin
                                        state <= S5;
                                    end
                                else
                                    begin
                                        state <= S6;
                                    end
                            end
                        S5: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S6;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[3] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[3] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end                         

                        S6: 
                            begin
                                if(rdusedw[4] >= YUZHI_POINT)
                                    begin
                                        state <= S7;
                                    end
                                else
                                    begin
                                        state <= S8;
                                    end
                            end
                        S7: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S8;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[4] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[4] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end 
                        S8: 
                            begin
                                if(rdusedw[5] >= YUZHI_POINT)
                                    begin
                                        state <= S9;
                                    end
                                else
                                    begin
                                        state <= S10;
                                    end
                            end
                        S9: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S10;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[5] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[5] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end    
                        S10: 
                            begin
                                if(rdusedw[6] >= YUZHI_POINT)
                                    begin
                                        state <= S11;
                                    end
                                else
                                    begin
                                        state <= S12;
                                    end
                            end
                        S11: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S12;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[6] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[6] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end  
                        S12: 
                            begin
                                if(rdusedw[7] >= YUZHI_POINT)
                                    begin
                                        state <= S13;
                                    end
                                else
                                    begin
                                        state <= S14;
                                    end
                            end
                        S13: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S14;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[7] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[7] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end  
                        S14: 
                            begin
                                if(rdusedw[8] >= YUZHI_POINT)
                                    begin
                                        state <= S15;
                                    end
                                else
                                    begin
                                        state <= S16;
                                    end
                            end
                        S15: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S16;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[8] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[8] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end    
                        S16: 
                            begin
                                if(rdusedw[9] >= YUZHI_POINT)
                                    begin
                                        state <= S17;
                                    end
                                else
                                    begin
                                        state <= S18;
                                    end
                            end
                        S17: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S18;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[9] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[9] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end  
                        S18: 
                            begin
                                if(rdusedw[10] >= YUZHI_POINT)
                                    begin
                                        state <= S19;
                                    end
                                else
                                    begin
                                        state <= S20;
                                    end
                            end
                        S19: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S20;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[10] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[10] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end
                        S20: 
                            begin
                                if(rdusedw[11] >= YUZHI_POINT)
                                    begin
                                        state <= S21;
                                    end
                                else
                                    begin
                                        state <= S22;
                                    end
                            end
                        S21: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S22;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[11] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[11] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end
                        S22: 
                            begin
                                if(rdusedw[12] >= YUZHI_POINT)
                                    begin
                                        state <= S23;
                                    end
                                else
                                    begin
                                        state <= S24;
                                    end
                            end
                        S23: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S24;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[12] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[12] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end    

                        S24: 
                            begin
                                if(rdusedw[13] >= YUZHI_POINT)
                                    begin
                                        state <= S25;
                                    end
                                else
                                    begin
                                        state <= S26;
                                    end
                            end
                        S25: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S26;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[13] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[13] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end                         

                        S26: 
                            begin
                                if(rdusedw[14] >= YUZHI_POINT)
                                    begin
                                        state <= S27;
                                    end
                                else
                                    begin
                                        state <= S28;
                                    end
                            end
                        S27: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S28;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[14] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[14] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end 
                        S28: 
                            begin
                                if(rdusedw[15] >= YUZHI_POINT)
                                    begin
                                        state <= S29;
                                    end
                                else
                                    begin
                                        state <= S30;
                                    end
                            end
                        S29: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S30;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[15] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[15] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end    
                        S30: 
                            begin
                                if(rdusedw[16] >= YUZHI_POINT)
                                    begin
                                        state <= S31;
                                    end
                                else
                                    begin
                                        state <= S32;
                                    end
                            end
                        S31: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S32;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[16] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[16] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end  
                        S32: 
                            begin
                                if(rdusedw[17] >= YUZHI_POINT)
                                    begin
                                        state <= S33;
                                    end
                                else
                                    begin
                                        state <= S34;
                                    end
                            end
                        S33: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S34;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[17] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[17] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end  
                        S34: 
                            begin
                                if(rdusedw[18] >= YUZHI_POINT)
                                    begin
                                        state <= S35;
                                    end
                                else
                                    begin
                                        state <= S36;
                                    end
                            end
                        S35: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S36;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[18] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[18] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end    
                        S36: 
                            begin
                                if(rdusedw[19] >= YUZHI_POINT)
                                    begin
                                        state <= S37;
                                    end
                                else
                                    begin
                                        state <= S38;
                                    end
                            end
                        S37: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S38;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[19] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[19] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end  
                        S38: 
                            begin
                                if(rdusedw[20] >= YUZHI_POINT)
                                    begin
                                        state <= S39;
                                    end
                                else
                                    begin
                                        state <= S40;
                                    end
                            end
                        S39: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S40;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[20] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[20] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end
                        S40: 
                            begin
                                if(rdusedw[21] >= YUZHI_POINT)
                                    begin
                                        state <= S41;
                                    end
                                else
                                    begin
                                        state <= S42;
                                    end
                            end
                        S41: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S42;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[21] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[21] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end
                        S42: 
                            begin
                                if(rdusedw[22] >= YUZHI_POINT)
                                    begin
                                        state <= S43;
                                    end
                                else
                                    begin
                                        state <= S44;
                                    end
                            end
                        S43: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S44;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[22] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[22] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end    

                        S44: 
                            begin
                                if(rdusedw[23] >= YUZHI_POINT)
                                    begin
                                        state <= S45;
                                    end
                                else
                                    begin
                                        state <= S46;
                                    end
                            end
                        S45: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S46;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[23] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[23] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end                         

                        S46: 
                            begin
                                if(rdusedw[24] >= YUZHI_POINT)
                                    begin
                                        state <= S47;
                                    end
                                else
                                    begin
                                        state <= S48;
                                    end
                            end
                        S47: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S48;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[24] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[24] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end 
                        S48: 
                            begin
                                if(rdusedw[25] >= YUZHI_POINT)
                                    begin
                                        state <= S49;
                                    end
                                else
                                    begin
                                        state <= S50;
                                    end
                            end
                        S49: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S50;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[25] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[25] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end    
                        S50: 
                            begin
                                if(rdusedw[26] >= YUZHI_POINT)
                                    begin
                                        state <= S51;
                                    end
                                else
                                    begin
                                        state <= S52;
                                    end
                            end
                        S51: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S52;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[26] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[26] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end  
                        S52: 
                            begin
                                if(rdusedw[27] >= YUZHI_POINT)
                                    begin
                                        state <= S53;
                                    end
                                else
                                    begin
                                        state <= S54;
                                    end
                            end
                        S53: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S54;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[27] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[27] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end  
                        S54: 
                            begin
                                if(rdusedw[28] >= YUZHI_POINT)
                                    begin
                                        state <= S55;
                                    end
                                else
                                    begin
                                        state <= S56;
                                    end
                            end
                        S55: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S56;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[28] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[28] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end    
                        S56: 
                            begin
                                if(rdusedw[29] >= YUZHI_POINT)
                                    begin
                                        state <= S57;
                                    end
                                else
                                    begin
                                        state <= S58;
                                    end
                            end
                        S57: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S58;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[29] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[29] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end  
                        S58: 
                            begin
                                if(rdusedw[30] >= YUZHI_POINT)
                                    begin
                                        state <= S59;
                                    end
                                else
                                    begin
                                        state <= S60;
                                    end
                            end
                        S59: 
                            begin
                                if(cnt[31:0] ==(YUZHI_POINT + 10))
                                    begin
                                        cnt[31:0] <= 32'd0;
                                        state <= S60;
                                    end
                                else
                                    begin
                                        cnt[31:0] <= cnt[31:0] +32'd1;
                                    end


                                if((cnt[31:0] >= 32'd3) &&  (cnt[31:0] <= (YUZHI_POINT + 2)))
                                    begin
                                        rdreq[30] <= 1'b1;
                                    end
                                else
                                    begin
                                        rdreq[30] <= 1'b0;
                                    end


                                if((cnt[31:0] >= 32'd2) &&  (cnt[31:0] <= (YUZHI_POINT + 3)))
                                    begin
                                        data_valid <= 1'b1;
                                    end
                                else
                                    begin
                                        data_valid <= 1'b0;
                                    end
                            end
                                                                                                 
                        S60:
                            begin
                                state <= IDLE;
                            end

                        default: 
                            begin
                                state <= IDLE;
                            end
                endcase
            end
    end

//输出
always @(*) 
    begin
        case (state)
            S1:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[1];
                    end
                else
                    begin
                        up_data <= q[1];
                    end
            S3:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[2];
                    end
                else
                    begin
                        up_data <= q[2];
                    end
            S5:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[3];
                    end
                else
                    begin
                        up_data <= q[3];
                    end    
            S7:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[4];
                    end
                else
                    begin
                        up_data <= q[4];
                    end 
            S9:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[5];
                    end
                else
                    begin
                        up_data <= q[5];
                    end
            S11:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[6];
                    end
                else
                    begin
                        up_data <= q[6];
                    end
            S13:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[7];
                    end
                else
                    begin
                        up_data <= q[7];
                    end
            S15:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[8];
                    end
                else
                    begin
                        up_data <= q[8];
                    end    
            S17:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[9];
                    end
                else
                    begin
                        up_data <= q[9];
                    end 
            S19:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[10];
                    end
                else
                    begin
                        up_data <= q[10];
                    end
            S21:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[11];
                    end
                else
                    begin
                        up_data <= q[11];
                    end
            S23:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[12];
                    end
                else
                    begin
                        up_data <= q[12];
                    end
            S25:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[13];
                    end
                else
                    begin
                        up_data <= q[13];
                    end    
            S27:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[14];
                    end
                else
                    begin
                        up_data <= q[14];
                    end 
            S29:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[15];
                    end
                else
                    begin
                        up_data <= q[15];
                    end
            S31:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[16];
                    end
                else
                    begin
                        up_data <= q[16];
                    end
            S33:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[17];
                    end
                else
                    begin
                        up_data <= q[17];
                    end
            S35:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[18];
                    end
                else
                    begin
                        up_data <= q[18];
                    end    
            S37:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[19];
                    end
                else
                    begin
                        up_data <= q[19];
                    end 
            S39:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[20];
                    end
                else
                    begin
                        up_data <= q[20];
                    end 
            S41:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[21];
                    end
                else
                    begin
                        up_data <= q[21];
                    end
            S43:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[22];
                    end
                else
                    begin
                        up_data <= q[22];
                    end
            S45:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[23];
                    end
                else
                    begin
                        up_data <= q[23];
                    end    
            S47:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[24];
                    end
                else
                    begin
                        up_data <= q[24];
                    end 
            S49:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[25];
                    end
                else
                    begin
                        up_data <= q[25];
                    end 
            S51:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[26];
                    end
                else
                    begin
                        up_data <= q[26];
                    end
            S53:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[27];
                    end
                else
                    begin
                        up_data <= q[27];
                    end
            S55:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[28];
                    end
                else
                    begin
                        up_data <= q[28];
                    end    
            S57:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[29];
                    end
                else
                    begin
                        up_data <= q[29];
                    end 
            S59:
                if(cnt[31:0] == 32'd3)
                    begin
                        up_data <= {XINGHAO,cnt_fifo};
                    end
                else if(cnt[31:0] == 32'd4)
                    begin
                        up_data <= cnt_fifo_send_packet[30];
                    end
                else
                    begin
                        up_data <= q[30];
                    end        
            default: 
                begin
                    up_data <= 64'd0;
                end
        endcase
    end

//实例化fifo_32x16384x64模块
    genvar i;
    generate
        for (i = 1;i <= 4 ;i = i + 1 ) 
            begin:iii
                fifo_32x16384x64	fifo_32x16384x64_inst (

	                .data    ( data[i]    ),
	                .rdclk   ( rdclk      ),
	                .rdreq   ( rdreq[i]   ),
	                .wrclk   ( wrclk      ),
	                .wrreq   ( wrreq[i]   ),
	                .q       ( q[i]       ),
	                .rdusedw ( rdusedw[i] )

	            );
        end
    endgenerate

endmodule