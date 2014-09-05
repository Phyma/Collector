
--dir
--0 tobus
--1 frombus

entity bus_mux is 
 port (	from_tb: in std_logic_vector(2 downto 0);
		from_fb: in std_logic_vector(2 downto 0);
		ir: inout std_logic_vector(15 downto 0);
		asr :out std_logic_vector(7 downto 0);
		pc : inout std_logic_vector(7 downto 0);
		pm: inout std_logic_vector(15 downto 0);
		alu: out std_logic_vector(15 downto 0);
		sr: inout std_logic_vector(3 downto 0);
		ar: in std_logic_vector(15 downto 0);
		hr : inout std_logic_vector(15 downto 0);
		grx: inout std_logic_vector(15 downto 0);
		dir: out std_logic;
	); 
       
  
end bus_mux;

architecture bus_mux_def of bus_mux is
 	signal tobus : std_logic_vector(15 downto 0);
	signal frombus : std_logic_vector(15 downto 0);
begin 

process
begin
	
	tobus <= ir WHEN from_tb = "001" ELSE
			pm WHEN from_tb = "010" ELSE
			pc WHEN from_tb = "011" ELSE
			ar when from_tb = "100" ELSE
			hr WHEN from_tb = "101" ELSE
			grx WHEN from_tb = "110" ELSE
			(tobus'range => '0');
			
	dir <= '0' WHEN from_tb = "001" ELSE
			'0' WHEN from_tb = "010" ELSE
			'0' WHEN from_tb = "011" ELSE
			'0' when from_tb = "100" ELSE
			'0' WHEN from_tb = "101" ELSE
			'0' WHEN from_tb = "110" ELSE
			'0';		
	
			
	CASE from_fb is
		WHEN "001" => ir <= tobus; dir <= '1';
		WHEN "010" => pm <= tobus; dir <= '1';
		WHEN "011" => pc <= tobus; dir <= '1';
		WHEN "101" => hr <= tobus; dir <= '1';
		WHEN "110" => grx <= tobus; dir<= '1';
		WHEN "111" => asr <= tobus; dir <= '1';
		WHEN OTHERS => dir <= '0';
	end case;			
	
	
end process;
end bus_mux_def;
