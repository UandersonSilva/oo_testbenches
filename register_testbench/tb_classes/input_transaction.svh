class input_transaction;
    logic [DATA_WIDTH - 1:0] reg_in;
    logic reg_wr, reg_reset;

    function bit compare(input_transaction compared);
        bit same = 0;
        if(compared == null)
            $display("[INPUT TRANSACTION]: Null pointer. Comparison aborted.");
        else
            same = (compared.reg_in == reg_in) &&
                   (compared.reg_wr == reg_wr) &&
                   (compared.reg_reset == reg_reset);

        return same;
    endfunction : compare

    function void copy(input_transaction copied);
        reg_in    = copied.reg_in;
        reg_wr    = copied.reg_wr;
        reg_reset = copied.reg_reset;
    endfunction : copy

    function input_transaction clone();
        input_transaction cloned;
        cloned = new();

        cloned.reg_in    = reg_in;
        cloned.reg_wr    = reg_wr;
        cloned.reg_reset = reg_reset;

        return cloned;
    endfunction : clone

    function string convert2string();
        string s;
        s = $sformatf("reg_in: %4h reg_wr: %b reg_reset: %b", reg_in, reg_wr, reg_reset);

        return s;
    endfunction : convert2string

endclass : input_transaction