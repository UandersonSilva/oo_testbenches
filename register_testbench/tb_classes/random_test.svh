class random_test extends base_test;
    task run;
        super.run();
      
         data_i = new();
         data_i.reg_reset = 1;
         super.insert_data();
      
         @(data_i.done);
      
        repeat(29)
        begin            
            data_i = new();

            assert(data_i.randomize());
            data_i.reg_reset = 0;
            super.insert_data();
            
            @(data_i.done);
        end
    endtask : run
endclass : random_test