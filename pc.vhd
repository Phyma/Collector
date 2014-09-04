entity pc is
	port(clk: in std_logic;
		bus_connect: inout std_logic_vector(7 downto 0);
		ctrl: in std_logic;
		incr: in std_logic;
		rst: in std_logic
		);
end pc;

architecture pc_def of pc is
	signal reg : std_logic_vector(7 downto 0) := (reg'range => '0');
begin

process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		reg <= (reg'range => '0');
	elsif ctrl = '0' then
		bus_connect <= reg;
	elsif ctrl = '1' then
		reg <= bus_connect;
	end if;
	
	if incr = '1' then
		reg <= reg + 1;
end if;
end process;
end pc_def;
		