class scoreboard;
    transaction_port #(input_transaction) scoreboard_ap_in;
    transaction_port #(output_transaction) scoreboard_ap_out;

    event input_read;
    event output_read;

    logic [DATA_WIDTH - 1:0] prev_reg_out = 0;

    task run();
        input_transaction  t_in;
        output_transaction t_out, predicted;

        forever 
        begin
            predicted = new();

            @(input_read);
            scoreboard_ap_in.read(t_in);

            if(t_in == null)
                $display("%0t [SCOREBOARD]: No input transaction. Null pointer.", $time);
            else
            begin
                if(t_in.reg_reset)
                    predicted.reg_out = 16'h0000;
                else if(t_in.reg_wr)
                    predicted.reg_out = t_in.reg_in;
                else
                    predicted.reg_out = prev_reg_out;
            end

            @(output_read);
            scoreboard_ap_out.read(t_out);

            if(t_out == null)
                $display("%0t [SCOREBOARD]: No output transaction. Null pointer.", $time);
            else
            begin
                if(t_out.compare(predicted))
                    $display("%0t", $time, {" [SCOREBOARD]: PASS:: ", t_in.convert2string(), 
                    " => ", t_out.convert2string(), " || Predicted => ", predicted.convert2string()});
                else
                    $display("%0t", $time, {"% [SCOREBOARD]: FAIL:: ", t_in.convert2string(), 
                    " => ", t_out.convert2string(), " || Predicted => ", predicted.convert2string()});

                prev_reg_out = t_out.reg_out;
            end
        end
    endtask : run
endclass : scoreboard