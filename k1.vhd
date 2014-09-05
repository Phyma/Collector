entity k1 is
	port(clk: in std_logic;		
		rst: in std_logic;
		op: in std_logic_vector(3 downto 0);
		to_upc: in std_logic_vector(6 downto 0);
		);
end k1;

architecture k1_def of k1 is
type mem_t is array of (0 to 15) of std_logic_vector(6 downto 0);
constant grr : mem_t := (grr'range => "0000000");
signal mem:mem_t := grr;

begin

process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		mem <= (mem'range => "0000000");;
	else
		to_upc <= mem(conv_integer(op));
	end if;
end if;
end process;
end k1_def;
		