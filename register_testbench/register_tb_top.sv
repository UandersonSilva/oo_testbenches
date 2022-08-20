`include "./register/register.sv"
`include "register_tb_pkg.sv"
`include "register_interface.sv"


module register_tb_top;
    import register_tb_pkg::*;

    register_interface reg_if();

    register r0(
        .reg_in(reg_if.reg_in), 
        .reg_wr(reg_if.reg_wr),
        .reg_reset(reg_if.reg_reset),
        .clock(reg_if.clock), 
        .reg_out(reg_if.reg_out)
    );

    random_test t0;

    initial
    begin
        t0 = new();
        t0.env_r.reg_if = reg_if;
        t0.run();
        #20;
        $finish;
    end
endmodule : register_tb_top