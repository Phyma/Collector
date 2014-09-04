entity grx is 
 port (clk: in std_logic;
       bus_connect: inout std_logic_vector(15 downto 0);
       ctrl_reg: in std_logic_vector(1 downto 0);
	   ctrl : in std_logic;
	   rst : in std_logic);
       
  
end grx;

architecture grx_def of grx is
	signal gr1: std_logic_vector(15 downto 0) := (gr1'range => '0'); 
	signal gr2: std_logic_vector(15 downto 0) := (gr2'range => '0'); 
	signal gr3: std_logic_vector(15 downto 0) := (gr3'range => '0'); 
	signal gr4: std_logic_vector(15 downto 0) := (gr4'range => '0'); 	
begin 

process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then 
		gr1 <= (gr1'range => '0');
		gr2 <= (gr2'range => '0');
		gr3 <= (gr3'range => '0');
		gr4 <= (gr4'range => '0');	
	else
		if ctrl = '0' then
			bus_connect <= gr1 WHEN (ctrl_reg = "00") ELSE
							gr2 WHEN (ctrl_reg = "01") ELSE
							gr3 WHEN (ctrl_reg = "10") ELSE
							gr4 WHEN (ctrl_reg = "11") ELSE
							'X';
		elsif ctrl = '1' then
			bus_connect => gr1 WHEN (ctrl_reg = "00") ELSE
							gr2 WHEN (ctrl_reg = "01") ELSE
							gr3 WHEN (ctrl_reg = "10") ELSE
							gr4 WHEN (ctrl_reg = "11") ELSE
							'X';
		end if;
	end if;
end if; 
end process;
end grx_def;
