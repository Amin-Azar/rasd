(* techmap_celltype = "$add" *)
module add_map_1_ (A, B, Y);

parameter A_SIGNED = 0;
parameter B_SIGNED = 0;
parameter A_WIDTH = 0;
parameter B_WIDTH = 0;
parameter Y_WIDTH = 0;

input [A_WIDTH-1:0] A;
input [B_WIDTH-1:0] B;
output [Y_WIDTH-1:0] Y;

ETAIIM32 #(
    .A_SIGNED(A_SIGNED),
    .B_SIGNED(B_SIGNED),
    .A_WIDTH(A_WIDTH),
    .B_WIDTH(B_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A), .B(B), .Y(Y)
);

endmodule
