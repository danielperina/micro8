library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_mem8x8 is
	--port(
	--	clk, we: in std_logic;
	--	din, addr: in std_logic_vector(7 downto 0);
	--	dout: out std_logic_vector(7 downto 0) 
	--);
end entity;

architecture behavioral of tb_mem8x8 is
	
	signal tb_clk	: std_logic := '0';
	signal tb_we	: std_logic := '0';

	signal tb_din	: std_logic_vector(7 downto 0) := (others => '0');
	signal tb_addr	: std_logic_vector(7 downto 0) := (others => '0');
	signal tb_dout	: std_logic_vector(7 downto 0) := (others => '0');

begin

	uut: entity work.mem8x8 port map(
		clk => tb_clk,
		we => tb_we,
		din => tb_din,
		addr => tb_addr,
		dout => tb_dout
	);

	process
	begin

		for i in 0 to 255 loop

			tb_din <= std_logic_vector(to_unsigned(i, 8));
			tb_addr <= std_logic_vector(to_unsigned(i, 8));

			wait for 5 ns;
			tb_clk <= '1';
			wait for 5 ns;
			tb_clk <= '0';

			assert tb_dout = x"00" report "Unexpected value for dout at test1 no." & integer'image(i) severity error;

		end loop;

		tb_we <= '1';
		for i in 0 to 255 loop

			tb_din <= std_logic_vector(to_unsigned(i, 8));
			tb_addr <= std_logic_vector(to_unsigned(i, 8));

			wait for 5 ns;
			tb_clk <= '1';
			wait for 5 ns;
			tb_clk <= '0';

			assert tb_dout = std_logic_vector(to_unsigned(i, 8)) report "Unexpected value for dout at test2 no." & integer'image(i) severity error;

		end loop;
		
		report "Tests finished." severity note;
		wait;
	end process;

end architecture;