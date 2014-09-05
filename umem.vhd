entity umem is
	port(clk: in std_logic;
		from_upc: in std_logic_vector(6 downto 0);			
		rst: in std_logic;
		to_bustb: out std_logic_vector(2 downto 0);
		to_busfb: out std_logic_vector(2 downto 0);
		to_upc : out std_logic_vector(3 downto 0);
		to_ir : out std_logic;
		to_pc: out std_logic;
		to_alu : out std_logic_vector(3 downto 0)
		);
end umem;

architecture umem_def of umem is
	type uline is
		record
			alu: std_logic_vector(3 downto 0);
			tb: std_logic_vector(2 downto 0);
			fb: std_logic_vector(2 downto 0);
			s: std_logic;
			p: std_logic_vector;
			lc: std_logic_vector(1 downto 0);
			seq: std_logic_vector(3 downto 0);
			uadr: std_logic_vector(6 downto 0);
		end record;
	
	type umem_t is array of (0 to 32) of uline;	
	constant umem_c : umem_t := (umem'range => ("0000","000","000",'0','0',"00", "0000","0000000"));
	signal umem : umemt := umem_c; 

begin

process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		umem <= (umem'range => ("0000","000","000",'0','0',"00", "0000","0000000"));
	else
		to_seq <= umem(conv_integer(from_upc)).seq;
		to_pc <= umem(conv_integer(from_upc)).p;
		to_alu <= umem(conv_integer(from_upc)).alu;
		to_ir <= umem(conv_integer(from_upc)).s;
		to_upc <= umem(conv_integer(from_upc)).uadr;
		to_bustb <= umem(conv_integer(from_upc)).tb;
		to_busfb <= umem(conv_integer(from_upc)).fb;
	end if;
end if;
end process;
end umem_def;
		