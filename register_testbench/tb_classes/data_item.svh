class data_item;
    rand logic [DATA_WIDTH - 1:0] reg_in;
    rand logic reg_wr;
    logic reg_reset = 0;
    logic [DATA_WIDTH - 1:0] reg_out;

    event done;

    function bit compare(data_item compared);
        bit same = 0;
        if(compared == null)
            $display("%0t [DATA ITEM]: Null pointer. Comparison aborted.", $time);
        else
            same = (compared.reg_in == reg_in) &&
                   (compared.reg_wr == reg_wr) &&
                   (compared.reg_reset == reg_reset) &&
                   (compared.reg_out == reg_out);

        return same;
    endfunction : compare

    function void copy(data_item copied);
        reg_in    = copied.reg_in;
        reg_wr    = copied.reg_wr;
        reg_reset = copied.reg_reset;
        reg_out   = copied.reg_out;
    endfunction : copy

    function data_item clone();
        data_item cloned;
        cloned = new();

        cloned.reg_in    = reg_in;
        cloned.reg_wr    = reg_wr;
        cloned.reg_reset = reg_reset;
        cloned.reg_out   = reg_out;

        return cloned;
    endfunction : clone

    function string convert2string();
        string s;
        s = $sformatf("reg_in: %4h reg_wr: %b reg_reset: %b => reg_out: %4h", reg_in, reg_wr, reg_reset, reg_out);

        return s;
    endfunction : convert2string

endclass : data_item