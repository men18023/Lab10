//Ejercicio 2
//ALU
//Jonathan Menendez 18023

//modulo del FlipFlop tipo D
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

//modulo del Buffer Tri estado
module BufferTri(
    input wire enable,
    input wire [3:0]In,
    output wire [3:0]Ex);

        assign Ex = (enable) ? In:4'bz;
endmodule

//modulo de ALU utilizado
module ALU(
    input wire [3:0]A,
    input wire [3:0]B,
    input wire [2:0]Com, // intrucciones de la ALU
    output reg [3:0]Res, //Resultados de las intrucciones
    output reg Carry,
    output reg Exit);

        reg [4:0]k; //Registro interno

        always @ (A or B or Com) begin

            case(Com)   //case para dar instrucion a cada caso del reg k

                3'b000: begin
                            //pasa A
                            k = 5'b00000;
                            k = A;
                            Carry = 1'b0;
                            Exit = (k == 5'b00000) ? 1:0;
                            Res = k[3:0];
                        end

                3'b001: begin
                            // Comparador
                            k[4:0] = 5'b00000;
                            k = A - B;
                            Carry = (k[4] == 5'b00000) ? 1:0;
                            Exit = (k == 5'b00000) ? 1:0;
                            Res = k[3:0];
                        end

                3'b010: begin
                            // pasa B
                            k[4:0] = 5'b00000;
                            k = B;
                            Carry = 1'b0;
                            Exit = (k == 5'b00000) ? 1:0;
                            Res = k[3:0];
                        end

                3'b011: begin
                            // suma
                            k[4:0] = 5'b00000;
                            k = A + B;
                            Carry = (k[4] == 5'b00000) ? 1:0;
                            Exit = (k == 5'b00000) ? 1:0;
                            Res = k[3:0];
                        end

                3'b100: begin
                            //NAND
                            k = 5'b00000;
                            k = ~(A & B);
                            Carry = 1'b0;
                            Exit = (k == 5'b00000) ? 1:0;
                            Res = k[3:0];
                        end
            endcase
        end
endmodule

//modulo de union de todos los modulos anteriores
module main(
    input wire [3:0]In,
    input wire enable, enable1, enable2, clk, reset,
    input wire [2:0]Com,
    output wire Carry, Exit,
    output wire [3:0]S);

        wire [3:0]a;
        wire [3:0]b;
        wire [3:0]alu_out;

        BufferTri u1(In, enable1, b);
        FFD4 u2(clk, reset, enable, alu_out, a);
        ALU u4(a, b, Com, alu_out, Carry, Exit);
        BufferTri u3(alu_out, enable2, S);

endmodule
