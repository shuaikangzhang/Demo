`timescale 1ns/1ns
module fifo_30_tb ();

    reg           rst_n      ;
    reg           rdclk      ;
    reg           wrclk      ;

    wire          data_valid ;
    wire  [63:0]  up_data    ;


    //初始化时钟和复位信号
    initial begin
        rst_n=1'b0;
        rdclk=1'b0;
        wrclk=1'b0;
        #200
        rst_n=1'b1;
    end
    
    //生成周期为20ns的时钟信号
    always #10 rdclk=~rdclk;
    always #10 wrclk=~wrclk;

//例化fifo_30顶层模块
fifo_30 fifo_30_inst (

    .rst_n      ( rst_n      ), 
    .rdclk      ( rdclk      ),
    .wrclk      ( wrclk      ),

    .data_valid ( data_valid ),
    .up_data    ( up_data    )

);

endmodule