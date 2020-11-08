//Ejercicio 2
//ALU_tb
//Jonathan Menendez 18023

module testbench();

reg [3:0]In;
reg enable1, clk, reset, enable, enable2;
reg [2:0]Com;
wire Carry, Exit;
wire [3:0]S;

//llamada al modulo principal
main u1(In, enable1, clk, reset, enable, enable2, Com, Carry, Exit, S);

always
    #1 clk = ~clk;

initial begin
    #1
    $display("-----------------------------------------------------------------------------");
    $display("| clk | enable |  In  | reset | enable1 | enable2 | Com || Carry | Exit | S |");
    $display("--------------------------------------------------------||------------");
    $monitor("|   %b     %b      %b     %b        %b      %b      %b    ||   %b    %b    %b  |", clk, enable, In, reset, enable1, enable2, Com, Carry, Exit, S);
    clk = 0; enable = 0; In = 4'b0000; reset = 0; enable1 = 0; enable2 = 0; Com = 3'b000;
    #2 reset = 1;
    #2 reset = 0;
    #2 In = 4'b0001; enable1 = 1;
    #2 enable = 1; enable2 = 1; Com = 3'b010;

end

initial
    #40 $finish;

initial begin
    $dumpfile("ALU_tb.vcd");
    $dumpvars(0, testbench);
end

endmodule
