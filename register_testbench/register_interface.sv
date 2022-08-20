interface register_interface();
    import register_tb_pkg::*;

    logic [DATA_WIDTH - 1:0] reg_in, reg_out; 
    logic reg_wr, reg_reset, clock;

    input_monitor  input_monitor_r;
    output_monitor output_monitor_r;

    event input_read;
    event output_read;

    initial
    begin
        clock = 0;
        forever 
        begin
           #10;
           clock = ~clock;
        end
    end

    task send_data(logic [DATA_WIDTH - 1:0] rg_in, logic rg_wr, logic rg_reset, logic [DATA_WIDTH - 1:0] rg_out);
        reg_in = rg_in;
        reg_wr = rg_wr;
        reg_reset = rg_reset;

        @(posedge clock);
        #2;
        rg_out = reg_out;
    endtask : send_data

    always @(negedge clock)
    begin : input_monitor_read
        #2;
        input_monitor_r.read(reg_in, reg_wr, reg_reset);
        -> input_read;
    end

    always @(posedge clock)
    begin : output_monitor_read
        #2;
        output_monitor_r.read(reg_out);
        -> output_read;
    end
endinterface : register_interface