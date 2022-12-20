	component system_t4 is
		port (
			clk_clk                : in  std_logic                    := 'X'; -- clk
			reset_reset_n          : in  std_logic                    := 'X'; -- reset_n
			st2led_0_ledcom_export : out std_logic_vector(3 downto 0);        -- export
			st2led_0_ledseg_export : out std_logic_vector(7 downto 0)         -- export
		);
	end component system_t4;

	u0 : component system_t4
		port map (
			clk_clk                => CONNECTED_TO_clk_clk,                --             clk.clk
			reset_reset_n          => CONNECTED_TO_reset_reset_n,          --           reset.reset_n
			st2led_0_ledcom_export => CONNECTED_TO_st2led_0_ledcom_export, -- st2led_0_ledcom.export
			st2led_0_ledseg_export => CONNECTED_TO_st2led_0_ledseg_export  -- st2led_0_ledseg.export
		);

