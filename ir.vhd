entity ir is 
 port (clk: in std_logic;       
       from_bus: in std_logic_vector(15 downto 0);
	   to_bus : out std_logic_vector(7 downto 0);
	   to_k1: out std_logic_vector(3 downto 0);
	   to_k2: out std_logic_vector(1 downto 0);
	   to_grx:out std_logic_vector(1 downto 0);
	   s: in	std_logic;
       rst : in std_logic;
        );
end ir;

architecture ir_def of ir is
	type ir_reg is
		record
			op : std_logic_vector(3 downto 0);
			grx : std_logic_vector(1 downto 0);
			m : std_logic_vector(1 downto 0);
			adr : std_logic_vector(7 downto 0);
		end record;	
		
	signal ir:ir_reg;
begin

process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		ir <= ("0000", "00", "00", "0000");
	else
		ir <= (from_bus(15 downto 12),from_bus(11 downto 10),from_bus(9 downto 8),from_bus(7 downto 0));
		to_k1 <= ir.op;
		to_k2 <= ir.m;
		to_grx <= ir.grx when s='0' else
					ir.m when s='1' else
					'X';
		
		to_bus <= ir.adr;    
end if;
end process;

end ir_def;

