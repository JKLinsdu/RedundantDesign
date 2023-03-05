library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity kreyvium_tb is
end entity kreyvium_tb;

architecture bench of kreyvium_tb is
    constant r  : integer := 256;
    
    signal clk     : std_logic := '1';
    signal reset_n : std_logic := '1';

    signal key : std_logic_vector(127 downto 0);
    signal iv  : std_logic_vector(127 downto 0);
    
    signal ready : std_logic;
    signal ks    : std_logic_vector(r-1 downto 0);

    constant clk_period   : time := 10 ns;
    constant reset_period : time := clk_period/4;

begin
  
    kreyvium : entity work.kreyvium port map (clk, reset_n, key, iv, ready, ks);
    
    clk_process : process
    	variable count : integer := 0;
    begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process clk_process;
    
    test : process
	
    begin

	    key <= x"E3E70682C2094CAC629F6FBED82C07CD";
	    iv  <= x"82E2E662F728B4FA42485E3A0A5D2F34";

        reset_n <= '0';
        wait for reset_period;
        reset_n <= '1';

        loop
            wait until ready = '1';
            wait for reset_period;
			exit when ready = '1';    
        end loop;

    assert false report "test finished" severity failure;


    end process test;

end architecture bench;
