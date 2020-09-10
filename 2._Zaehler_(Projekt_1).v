module CounterTestbench();

	// Variablen für Eingabe-Stimuli
	reg clk, res;

	// Erzeuge einmaligen Verlauf für reset-Signal
	initial
	begin
		// Erstelle Waveform mit allen Variablen
		$dumpfile("simres.vcd");
		$dumpvars;
		// Reset ist für 5 Zeiteinheiten HIGH, danach LOW
		res <= 1'b1;
		#5;
		res <= 1'b0;
		#25;
		// Beende Simulation nach 30 Zeiteinheiten
		$finish;
	end

	// Erzeuge periodischen Verlauf für clock-Signal
	always
	begin
		clk <= 1'b0; #2; clk <= 1'b1; #2;
	end

	// Instanz des zu testenden Moduls
	wire [3:0] out;
	Counter counter(.clock(clk), .reset(res), .count(out));
endmodule

module Counter #(parameter N = 4)
(
	input clock,
	input reset,
	output [N-1:0] count
);
	reg [N-1:0] q;
	always @(posedge clock)
	begin
		if (reset)
			q <= 'b0;
		else
			q <= q + 1'b1;
	end
	assign count = q;
endmodule
