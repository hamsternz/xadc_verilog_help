----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.12.2023 17:51:44
-- Design Name: 
-- Module Name: tb_xadc_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb_xadc_test is
end tb_xadc_test;

architecture Behavioral of tb_xadc_test is

    component xadc_test is
    port (
        clk   : in std_logic;
        vauxn : in std_logic_vector(15 downto 0);
        vauxp : in std_logic_vector(15 downto 0);
        vn    : in std_logic;
        vp    : in std_logic;
        sample     : out std_logic_vector(7 downto 0);
        new_sample : out std_logic
    );
    end component;

    signal clk        : std_logic;
    signal vauxn      : std_logic_vector(15 downto 0);
    signal vauxp      : std_logic_vector(15 downto 0);
    signal vn         : std_logic;
    signal vp         : std_logic;
    signal sample     : std_logic_vector(7 downto 0);
    signal new_sample : std_logic;
begin

process
    begin
        clk <= '0';
        wait for 5.0 ns;
        clk <= '1';
        wait for 5.0 ns;
    end process;

uut: xadc_test port map (
    clk        => clk,
    vauxn      => vauxn, 
    vauxp      => vauxn,
    vn         => vn,
    vp         => vp,
    sample     => sample,
    new_SAMPLE => new_sample
    );
end Behavioral;
