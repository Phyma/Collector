entity pm is 
 port (clk: in std_logic;
       from_asr: in std_logic_vector(7 downto 0);
       ctrl : in std_logic;  
       bus_connect: inout std_logic_vector(15 downto 0);
       rst : in std_logic;
        );
end pm;

architecture pm_def of pm is
  
begin
signal line : std_logic_vector(15 downto 0) := (line'range => '0');
type mem_t is array of (0 to 15) of line;
constant grr : mem_t := (grr'range => line);
signal mem: mem_t := grr;
process(clk)
begin
if rising_edge(clk) then
  if rst = '1' then
    line <= (line'range => '0');
    grr <= (grr'range => line);
  elsif ctrl='0' then
    mem(conv_integer(from_asr)) <= bus_connect;
  elsif ctrl='1' then
    bus_connect <=  mem(conv_integer(from_asr);
  end if;   
end if;
end process;

end pm_def;

