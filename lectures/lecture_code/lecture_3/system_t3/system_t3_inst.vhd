	component system_t3 is
		port (
			clk_clk                : in    std_logic                     := 'X';             -- clk
			reset_reset_n          : in    std_logic                     := 'X';             -- reset_n
			sdram_addr             : out   std_logic_vector(11 downto 0);                    -- addr
			sdram_ba               : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_cas_n            : out   std_logic;                                        -- cas_n
			sdram_cke              : out   std_logic;                                        -- cke
			sdram_cs_n             : out   std_logic;                                        -- cs_n
			sdram_dq               : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_dqm              : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_ras_n            : out   std_logic;                                        -- ras_n
			sdram_we_n             : out   std_logic;                                        -- we_n
			st2vga_video_data      : out   std_logic_vector(7 downto 0);                     -- video_data
			st2vga_video_h_sync    : out   std_logic;                                        -- video_h_sync
			st2vga_video_v_sync    : out   std_logic;                                        -- video_v_sync
			parallel_port_0_export : in    std_logic_vector(3 downto 0)  := (others => 'X')  -- export
		);
	end component system_t3;

	u0 : component system_t3
		port map (
			clk_clk                => CONNECTED_TO_clk_clk,                --             clk.clk
			reset_reset_n          => CONNECTED_TO_reset_reset_n,          --           reset.reset_n
			sdram_addr             => CONNECTED_TO_sdram_addr,             --           sdram.addr
			sdram_ba               => CONNECTED_TO_sdram_ba,               --                .ba
			sdram_cas_n            => CONNECTED_TO_sdram_cas_n,            --                .cas_n
			sdram_cke              => CONNECTED_TO_sdram_cke,              --                .cke
			sdram_cs_n             => CONNECTED_TO_sdram_cs_n,             --                .cs_n
			sdram_dq               => CONNECTED_TO_sdram_dq,               --                .dq
			sdram_dqm              => CONNECTED_TO_sdram_dqm,              --                .dqm
			sdram_ras_n            => CONNECTED_TO_sdram_ras_n,            --                .ras_n
			sdram_we_n             => CONNECTED_TO_sdram_we_n,             --                .we_n
			st2vga_video_data      => CONNECTED_TO_st2vga_video_data,      --          st2vga.video_data
			st2vga_video_h_sync    => CONNECTED_TO_st2vga_video_h_sync,    --                .video_h_sync
			st2vga_video_v_sync    => CONNECTED_TO_st2vga_video_v_sync,    --                .video_v_sync
			parallel_port_0_export => CONNECTED_TO_parallel_port_0_export  -- parallel_port_0.export
		);

