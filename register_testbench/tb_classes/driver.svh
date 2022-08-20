class driver;
    virtual register_interface reg_if;
    mailbox #(data_item) data_mbox;

    task run();
        data_item data_i;

        forever
        begin
            data_mbox.get(data_i);
            
            @(negedge reg_if.clock);
            #1;
            if(data_i == null)
                $display("%0t [DRIVER]: No data item.", $time);
            else
            begin
                reg_if.send_data(data_i.reg_in, data_i.reg_wr, data_i.reg_reset, data_i.reg_out);
                ->data_i.done;
            end
        end
    endtask : run

endclass : driver