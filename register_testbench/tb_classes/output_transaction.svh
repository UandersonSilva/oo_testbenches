class output_transaction;
    logic [DATA_WIDTH - 1:0] reg_out;

    function bit compare(output_transaction compared);
        bit same = 0;
        if(compared == null)
            $display("%0t [OUTPUT TRANSACTION]: Null pointer. Comparison aborted.", $time);
        else
            same = (compared.reg_out == reg_out);

        return same;
    endfunction : compare

    function void copy(output_transaction copied);
        reg_out = copied.reg_out;
    endfunction : copy

    function output_transaction clone();
        output_transaction cloned;
        cloned = new();

        cloned.reg_out = reg_out;

        return cloned;
    endfunction : clone

    function string convert2string();
        string s;
        s = $sformatf("reg_out: %4h", reg_out);

        return s;
    endfunction : convert2string

endclass : output_transaction