library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ufunc is
    generic (r : integer);
    port (x   : in std_logic_vector(0 to 287);
          key : in std_logic_vector(0 to 127); 
          iv  : in std_logic_vector(0 to 127); 

          y : out std_logic_vector(0 to 287);
          z : out std_logic_vector(0 to r-1));
end entity ufunc;

architecture parallel of ufunc is

    constant a1 : integer := 66;
    constant b1 : integer := 162;
    constant c1 : integer := 243;

    constant a2 : integer := 93;
    constant b2 : integer := 84;
    constant c2 : integer := 111;

    constant fa : integer := 69;
    constant fb : integer := 171;
    constant fc : integer := 264;

    signal r1 : std_logic_vector(0 to (a2-1)+r);
    signal r2 : std_logic_vector(0 to (b2-1)+r);
    signal r3 : std_logic_vector(0 to (c2-1)+r);
    signal temp : std_logic := '0';
	signal v1 : std_logic_vector(0 to (a2-1)+r);
    signal v2 : std_logic_vector(0 to (b2-1)+r);
    signal v3 : std_logic_vector(0 to (c2-1)+r);
	
    signal o1 : std_logic_vector(0 to r-1);
    signal o2 : std_logic_vector(0 to r-1);
    signal o3 : std_logic_vector(0 to r-1);
	signal o4 : std_logic_vector(0 to r-1);
    signal o5 : std_logic_vector(0 to r-1);
    signal o6 : std_logic_vector(0 to r-1);

begin

    r1(r to r+(a2-1))  <= x(0 to a2-1);
    r2(r to r+(b2-1))  <= x(a2 to (a2+b2)-1);
    r3(r to r+(c2-1))  <= x(a2+b2 to (a2+b2+c2)-1);

	
	t1 : if (r>a2) generate
	  alg1 : for i in r to r+(a2-a1-1) generate
         m1 : entity work.part_orig port map (
        	r1(i),
        	temp,
            temp, 
            temp, 
        	temp,
            o4(i-r),
        	v1(i)
        );
      end generate alg1;
	end generate t1;
	
	t2 : if (r>a1 and r<=a2) generate
	  alg11 : for i in r to r+(r-a1-1) generate
         m1 : entity work.part_orig port map (
        	r1(i),
        	temp,
            temp, 
            temp, 
        	temp,
            o4(i-r),
        	v1(i)
        );
      end generate alg11;
	end generate t2;
	
	t3 : if (r>b2) generate
	alg2 : for i in r to r+(a2+b2-b1-1) generate
	   m2 : entity work.part_orig port map (
        	r2(i),
        	temp,
            temp, 
            temp, 
        	temp,
            o5(i-r),
        	v2(i)
        );
    end generate alg2;
	end generate t3;
	
	t4 : if (r>b1-a2 and r<=b2) generate
	alg21 : for i in r to r+(a2+r-b1-1) generate
	   m2 : entity work.part_orig port map (
        	r2(i),
        	temp,       
            temp, 
            temp, 
        	temp,
            o5(i-r),
        	v2(i)
        );
    end generate alg21;
	end generate t4;
	
	t5 : if (r>c2) generate
	alg3 : for i in r to r+(a2+b2+c2-c1-1) generate
		m3 : entity work.part_orig port map (
        	r3(i),
        	temp,
            temp, 
            temp, 
        	temp,
            o6(i-r),
        	v3(i)
        );
    end generate alg3;
	end generate t5;
	
	t6 : if (r>c1-a2-b2 and r<=c2) generate
	alg31 : for i in r to r+(a2+b2+r-c1-1) generate
		m3 : entity work.part_orig port map (
        	r3(i),
        	temp,
            temp, 
            temp, 
        	temp,
            o6(i-r),
        	v3(i)
        );
    end generate alg31;
	end generate t6;
	
    alg : for i in 0 to r-1 generate
        aalg1 : if ((i<=c1-a2-b2-1) or (i>c2-1)) generate
        p1 : entity work.part generic map (true) port map  (
        	r3((c1-1) + (r-(a2+b2)) - i),
        	r3(((a2+b2+c2)-1) + (r-(a2+b2)) - i),
            r3(((a2+b2+c2)-3) + (r-(a2+b2)) - i),
        	r3(((a2+b2+c2)-2) + (r-(a2+b2)) - i),
        	r1((fa-1) + r - i),
			key(i mod 128),
            o3(i),
        	r1(r - i - 1)
        );
		end generate;
		
		aalg2 : if i>c1-a2-b2-1 and i<=fa-1 generate
        p1 : entity work.part generic map (true) port map  (
        	r3((c1-1) + (r-(a2+b2)) - i),
        	v3(((a2+b2+c2)-1) + (r-(a2+b2)) - i),
            v3(((a2+b2+c2)-3) + (r-(a2+b2)) - i),
        	v3(((a2+b2+c2)-2) + (r-(a2+b2)) - i),
        	v1((fa-1) + r - i),
			key(i mod 128),
            o3(i),
        	r1(r - i - 1)
        );
        end generate;
		
		aalg3 : if i>fa-1 and i<=c2-3 generate
        p1 : entity work.part generic map (true) port map  (
        	r3((c1-1) + (r-(a2+b2)) - i),
        	v3(((a2+b2+c2)-1) + (r-(a2+b2)) - i),
            v3(((a2+b2+c2)-3) + (r-(a2+b2)) - i),
        	v3(((a2+b2+c2)-2) + (r-(a2+b2)) - i),
        	r1((fa-1) + r - i),
			key(i mod 128),
            o3(i),
        	r1(r - i - 1)
        );
        end generate;
		
		aalg4 : if  i=c2-2 generate
        p1 : entity work.part generic map (true) port map  (
        	r3((c1-1) + (r-(a2+b2)) - i),
        	v3(((a2+b2+c2)-1) + (r-(a2+b2)) - i),
            r3(((a2+b2+c2)-3) + (r-(a2+b2)) - i),
        	v3(((a2+b2+c2)-2) + (r-(a2+b2)) - i),
        	r1((fa-1) + r - i),
			key(i mod 128),
            o3(i),
        	r1(r - i - 1)
        );
        end generate;
		
		aalg5 : if  i=c2-1 generate
        p1 : entity work.part generic map (true) port map  (
        	r3((c1-1) + (r-(a2+b2)) - i),
        	v3(((a2+b2+c2)-1) + (r-(a2+b2)) - i),
            r3(((a2+b2+c2)-3) + (r-(a2+b2)) - i),
        	r3(((a2+b2+c2)-2) + (r-(a2+b2)) - i),
        	r1((fa-1) + r - i),
			key(i mod 128),
            o3(i),
        	r1(r - i - 1)
        );
        end generate;
		
        balg1 : if i<=a1-1 or i>a2-1 generate
        p2 : entity work.part generic map(false) port map (
            r1((a1-1) + r - i),
        	r1((a2-1) + r - i),
            r1((a2-3) + r - i),
        	r1((a2-2) + r - i),
        	r2((fb-1) + (r-a2) - i),
			iv(i mod 128),
            o1(i),
        	r2(r - i - 1)
        );
        end generate;

        balg2 : if i>a1-1 and i<=fb-a2-1 generate
        p2 : entity work.part generic map(false) port map (
            r1((a1-1) + r - i),
        	v1((a2-1) + r - i),
            v1((a2-3) + r - i),
        	v1((a2-2) + r - i),
        	v2((fb-1) + (r-a2) - i),
			iv(i mod 128),
            o1(i),
        	r2(r - i - 1)
        );
        end generate;
		
		balg3 : if i>fb-a2-1 and i<=a2-3 generate
        p2 : entity work.part generic map(false) port map (
            r1((a1-1) + r - i),
        	v1((a2-1) + r - i),
            v1((a2-3) + r - i),
        	v1((a2-2) + r - i),
        	r2((fb-1) + (r-a2) - i),
			iv(i mod 128),
            o1(i),
        	r2(r - i - 1)
        );
        end generate;
		
		balg4 : if i=a2-2 generate
        p2 : entity work.part generic map(false) port map (
            r1((a1-1) + r - i),
        	v1((a2-1) + r - i),
            r1((a2-3) + r - i),
        	v1((a2-2) + r - i),
        	r2((fb-1) + (r-a2) - i),
			iv(i mod 128),
            o1(i),
        	r2(r - i - 1)
        );
        end generate;
		
		balg5 : if i=a2-1 generate
        p2 : entity work.part generic map(false) port map (
            r1((a1-1) + r - i),
        	v1((a2-1) + r - i),
            r1((a2-3) + r - i),
        	r1((a2-2) + r - i),
        	r2((fb-1) + (r-a2) - i),
			iv(i mod 128),
            o1(i),
        	r2(r - i - 1)
        );
        end generate;

        calg1 : if i<=b1-a2-1 or (i>b2-1 and i>fc-a2-b2-1) generate
        p3 : entity work.part_orig port map (
        	r2((b1-1) + (r-a2) - i),
        	r2(((a2+b2)-1) + (r-a2) - i),
            r2(((a2+b2)-3) + (r-a2) - i),
        	r2(((a2+b2)-2) + (r-a2) - i),
        	r3((fc-1) + (r-(a2+b2)) - i),
        	o2(i),
        	r3(r - i - 1)
        );
        end generate;
		
		calg2 : if i>b1-a2-1 and i<=b2-3 generate
        p3 : entity work.part_orig port map (
        	r2((b1-1) + (r-a2) - i),
        	v2(((a2+b2)-1) + (r-a2) - i),
            v2(((a2+b2)-3) + (r-a2) - i),
        	v2(((a2+b2)-2) + (r-a2) - i),
        	v3((fc-1) + (r-(a2+b2)) - i),
        	o2(i),
        	r3(r - i - 1)
        );
		end generate;
		
		calg3 : if i=b2-2 generate
        p3 : entity work.part_orig port map (
        	r2((b1-1) + (r-a2) - i),
        	v2(((a2+b2)-1) + (r-a2) - i),
            r2(((a2+b2)-3) + (r-a2) - i),
        	v2(((a2+b2)-2) + (r-a2) - i),
        	v3((fc-1) + (r-(a2+b2)) - i),
        	o2(i),
        	r3(r - i - 1)
        );
		end generate;
		
		calg4 : if i=b2-1 generate
        p3 : entity work.part_orig port map (
        	r2((b1-1) + (r-a2) - i),
        	v2(((a2+b2)-1) + (r-a2) - i),
            r2(((a2+b2)-3) + (r-a2) - i),
        	r2(((a2+b2)-2) + (r-a2) - i),
        	v3((fc-1) + (r-(a2+b2)) - i),
        	o2(i),
        	r3(r - i - 1)
        );
		end generate;
		
		calg5 : if i<=fc-a2-b2-1 and i>b2-1 generate
        p3 : entity work.part_orig port map (
        	r2((b1-1) + (r-a2) - i),
        	r2(((a2+b2)-1) + (r-a2) - i),
            r2(((a2+b2)-3) + (r-a2) - i),
        	r2(((a2+b2)-2) + (r-a2) - i),
        	v3((fc-1) + (r-(a2+b2)) - i),
        	o2(i),
        	r3(r - i - 1)
        );
		end generate;
        
        z(i) <= o1(i) xor o2(i) xor o3(i);
    end generate alg;
    
    y <= r1(0 to a2-1) & r2(0 to b2-1) & r3(0 to c2-1);

end architecture parallel;

