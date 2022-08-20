class input_monitor;
    transaction_port #(input_transaction) monitor_ap;

    function void read(logic [DATA_WIDTH - 1:0] reg_in, logic reg_wr, logic reg_reset);
        input_transaction t_in;
        t_in = new();

        t_in.reg_in    = reg_in;
        t_in.reg_wr    = reg_wr;
        t_in.reg_reset = reg_reset;

        monitor_ap.write(t_in);
    endfunction : read
endclass : input_monitor