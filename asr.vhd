entity asr is
	port(clk: in std_logic;
		from_bus: in std_logic_vector(7 downto 0);	
		to_pm: out std_logic_vector(7 downto 0);
		rst: in std_logic
		);
end asr;

architecture asr_def of asr is
	signal reg : std_logic_vector(7 downto 0) := (reg'range => '0');
begin

process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		reg <= (reg'range => '0');
	else
		to_pm <= reg;
		reg <= from_bus;		
	end if;
end if;
end process;
end asr_def;
		