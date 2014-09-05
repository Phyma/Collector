
/*
	SEQ:
	0000 upc++
	0001 upc=k1
	0010 upc=k2
	0011 upc=0
	0101 upc=uadr
	
*/

entity upc is
	port(clk: in std_logic;
		from_k1: in std_logic_vector(6 downto 0);
		from k2 :in std_logic_vector(6 downto 0);		
		seq: in std_logic_vector(3 downto 0);
		rst: in std_logic;
		to_umem : out std_logic_vector(6 downto 0);
		from_uadr : in std_logic_vector(6 downto 0)
		);
end upc;

architecture upc_def of upc is
	signal reg : std_logic_vector(6 downto 0) := (reg'range => '0');
begin

process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		reg <= (reg'range => '0');
	else
		reg <= reg+1 WHEN seq = "0000" ELSE
				from_k1 WHEN seq = "0001" ELSE
				from_k2 WHEN seq = "0010" ELSE
				(reg'range => '0') WHEN seq ="0011" ELSE
				from_uadr WHEN seq = "0101" ELSE
				'X';	
	end if;
		 
end if;
end process;
	to_umem <= reg;
end upc_def;
		