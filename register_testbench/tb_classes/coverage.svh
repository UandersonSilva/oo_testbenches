class coverage;
    transaction_port #(input_transaction) coverage_ap;

    logic [DATA_WIDTH - 1:0] reg_in;
    logic reg_wr;

    event input_read;

    covergroup reg_inputs;
        register_in: coverpoint reg_in {
            bins zeros  = {'h0000};
            bins others = {['h0001:'hFFFE]};
            bins ones   = {'hFFFF};
        }

        write_signal: coverpoint reg_wr;
    endgroup

    function new();
        reg_inputs = new();
    endfunction : new

    task run();
        input_transaction t_in;
        
        forever
        begin
            @(input_read);

            coverage_ap.read(t_in);

            if(t_in == null)
                $display("%0t [COVERAGE]: Null pointer.", $time);
            else
            begin
                reg_in = t_in.reg_in;
                reg_wr = t_in.reg_wr;
                reg_inputs.sample;
            end
        end
    endtask : run
endclass : coverage