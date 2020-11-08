//testbench EJER1
//Jonathan Menendez 18023

module testbench();

//llamar todos los dato que se quieren evaluar
reg clk, reset, enable, enable2, bitcar;
reg [11:0]L;
wire [3:0]Q1;
wire [3:0]Q2;
wire [7:0]Pb;

main u1(clk, reset, enable, bitcar, enable2, L, Pb, Q1, Q2);

//clock y muestras de datos
always
    #1 clk = ~clk;
initial begin
    #1
    $display("------------------------------------------------------------");
    $display("clk  |  reset  |  enable  |  bitcar  |  enable2  |   L  ||  Pb |  Q1  |  Q2");
    $display("--------------------------------------------------------||------------");
    $monitor("   %b     %b     %b     %b     %b     %b    ||     %b     %b    %b  ", clk, reset, enable, bitcar, enable2, L, Pb, Q1, Q2);
    clk = 0; reset = 0; enable = 0; enable2 = 0; bitcar = 0; L = 12'b000000000000;
    #2 reset = 1;
    #2 reset = 0;
    #2 enable = 1;
    #2 enable2 = 1;
    #2 bitcar = 1;
    #2 L = 12'b000000000001;
    #2 L = 12'b000000001010;
    #2 bitcar = 0;
    #2 bitcar = 1;
    #2 enable = 1; L = 12'b000111001010;
    #2 enable2 = 1; L = 12'b110001001010;
end

initial
  #25 $finish;

//instruccion para GTKWave
initial begin
  $dumpfile("EJER1_tb.vcd");
  $dumpvars(0, testbench);
end

endmodule
