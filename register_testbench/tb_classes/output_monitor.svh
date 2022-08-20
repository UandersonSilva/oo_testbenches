class output_monitor;
    transaction_port #(output_transaction) monitor_ap;
    
    function void read(logic [DATA_WIDTH - 1:0] reg_out);
        output_transaction t_out;
        t_out = new();

        t_out.reg_out = reg_out;

        monitor_ap.write(t_out);
    endfunction : read
endclass : output_monitor