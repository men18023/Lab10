//Ejercicio 01
//Lab 10
//Jonathan Menendez 18023

//FliFlop tipo D para uso en fetch
module FFD4(
    input wire clk, reset, enable,
    input wire [3:0]D,
    output reg [3:0]Q);

    always @ (posedge clk or posedge reset) begin
        if (reset)
            Q <= 4'b0000;
        else if (enable)
            Q <= D;
    end
endmodule

//Modulo del counter de 12 bits
module counter(
    input wire clk, reset, enable, bitcar,
    input wire [11:0]L,
    output reg [11:0]E);

        always @ (posedge clk or posedge reset or posedge bitcar)begin
            if (reset == 1) // Empieza en 0
                E <= 12'b000000000000;

            else if(enable == 1) // Cada vez que pase el clock se le suma uno
                E <= E + 1;

            else if(bitcar == 1) // Mientras non sea 1, el valor va a ser el de load
                E <= L;
            end

endmodule

//Modulo de ROM para la memoria "memory.jmc"
module rom(
    input wire[11:0]Lect,
    output wire [7:0]Data);

        reg [7:0] Memory[0:4095]; // Tamaño de nuestra memoria

        initial begin
            $readmemb("memory.jmc", Memory); //llamar a nuestro archivo de datos
        end

        assign Data = Memory[Lect];
endmodule

//modulo fetch (FlipFlop de 8 bits) utilizando el de 4 bits para salidas
module fetch(
    input wire clk, reset, enable2,
    input wire [7:0]D8,
    output wire [3:0]Q1,
    output wire [3:0]Q2);  //dos salidas de 4

        FFD4 u1(clk, reset, enable2, D8[7:4], Q1);
        FFD4 u2(clk, reset, enable2, D8[3:0], Q2);
endmodule

//modulo de union de todos los modulos anteriores.
module main(
    input wire clk, reset, enable, non, enable2,
    input wire [11:0]L,
    output wire [7:0]Pb,
    output wire [3:0]Q1,
    output wire [3:0]Q2);

        wire [11:0]C;

        counter u1(clk, reset, enable, bitcar, L, C);
        rom u2(C, Pb);
        fetch u3(clk, reset, enable2, Pb, Q1, Q2);
endmodule
