module stled
    #(parameter
        DIV = 16 )
 (
    input clk_clk,
    input reset_reset_n,
    output ready,// можно принимать данные
    input valid, // можно забирать данные данные
    input [7:0]data,
    input startofpacket,
    input endofpacket,

    output [3:0]led_com,
    output [7:0]led_seg
    );


reg [DIV-1:0] div_cnt;
reg [7:0]l_seg;

reg [1:0]l_cnt;
wire [3:0]l_com;

assign l_com = 4'b0001 << l_cnt;
assign ready = div_cnt == 0;


always @(posedge clk_clk) begin
    if (!reset_reset_n)  begin  //обнуляем все счетчики во время сброса
        l_cnt <= 0;
        div_cnt <= 0;
    end else
    begin
        div_cnt <= div_cnt + 1; // инкрементируем делитель частоты

        if (div_cnt == 0) begin // работаем на пониженной частоте
            if (valid) begin  // если данные валидные - забираем их
                l_seg <= data;
            end

            if (startofpacket) begin // начало пакета обнуляем счетчик
                l_cnt <= 0;
            end else
            begin
                l_cnt <= l_cnt + 1; // если не начало просто шагаем вперед
            end
        end

    end

end

assign led_com = valid ? ~l_com : 'bz;
assign led_seg = l_seg;


endmodule
