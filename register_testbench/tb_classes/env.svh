class env;
    transaction_port #(input_transaction) env_ap_in;
    transaction_port #(output_transaction) env_ap_out;
    mailbox #(data_item) data_mbox;

    driver         driver_r;
    coverage       coverage_r;
    scoreboard     scoreboard_r;
    input_monitor  input_monitor_r;
    output_monitor output_monitor_r;
    virtual register_interface reg_if;

    function new();
        env_ap_in  = new();
        env_ap_out = new();
        
        driver_r         = new();
        coverage_r       = new();
        scoreboard_r     = new();
        input_monitor_r  = new();
        output_monitor_r = new();
    endfunction : new

    task run();
        reg_if.input_monitor_r  = input_monitor_r;
        reg_if.output_monitor_r = output_monitor_r;
        
        driver_r.reg_if = reg_if;

        driver_r.data_mbox = data_mbox;

        input_monitor_r.monitor_ap  = env_ap_in;
        output_monitor_r.monitor_ap = env_ap_out;

        coverage_r.coverage_ap         = env_ap_in;
        scoreboard_r.scoreboard_ap_in  = env_ap_in;
        scoreboard_r.scoreboard_ap_out = env_ap_out;

        coverage_r.input_read = driver_r.reg_if.input_read;
        scoreboard_r.input_read = driver_r.reg_if.input_read;
        scoreboard_r.output_read = driver_r.reg_if.output_read;

        fork
            driver_r.run();
            coverage_r.run();
            scoreboard_r.run();
        join_any
            
    endtask : run

endclass : env