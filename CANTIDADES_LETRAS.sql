
  CREATE OR REPLACE FUNCTION "CANTIDADES_LETRAS" (NUMERO in number) RETURN VARCHAR2 IS
 
centimos 		varchar2(2);
millares 		varchar2(3);
unimills 		varchar2(3);
unimilos 		varchar2(3);
unibilos 		varchar2(3);
numeroch 		varchar2(100);
resultado 	varchar2(1800);
resultado1 	varchar2(200);
 
function unidades(uni in varchar2) return varchar2 is
begin 
if uni='1'    then return('UN');
elsif uni='2' then return('DOS');
elsif uni='3' then return('TRES');
elsif uni='4' then return('CUATRO');
elsif uni='5' then return('CINCO');
elsif uni='6' then return('SEIS');
elsif uni='7' then return('SIETE');
elsif uni='8' then return('OCHO');
elsif uni='9' then return('NUEVE');
else  		         return null;	
end if;
end;
 
 
function decenas(dece in varchar2) return varchar2 is
begin
if substr(dece,1,1)='1' then
	if dece='10'    then  return('DIEZ');
	elsif dece='11' then  return('ONCE');
	elsif dece='12' then  return('DOCE');
	elsif dece='13' then  return('TRECE');
	elsif dece='14' then  return('CATORCE');
	elsif dece='15' then  return('QUINCE');
	elsif dece='16' then  return('DIESCISEIS');
	elsif dece='17' then  return('DIESCISIETE');
	elsif dece='18' then  return('DIESCIOCHO');
	elsif dece='19' then  return('DIESCINUEVE');
	else		              return null;	
	end if;
 
elsif substr(dece,1,1)='2' then
	if dece='20' then
		return('VEINTE');
	else
		return('VEINTI'||unidades(substr(dece,2,1)));	
	end if;
elsif substr(dece,1,1)='3' then
	if dece='30' then
		return('TREINTA');
	else
		return('TREINTA Y '||unidades(substr(dece,2,1)));	
	end if;
elsif substr(dece,1,1)='4' then
	if dece='40' then
		return('CUARENTA');
	else
		return('CUARENTA Y '||unidades(substr(dece,2,1)));	
	end if;
elsif substr(dece,1,1)='5' then
	if dece='50' then
		return('CINCUENTA');
	else
		return('CINCUENTA Y '||unidades(substr(dece,2,1)));	
	end if;
elsif substr(dece,1,1)='6' then
	if dece='60' then
		return('SESENTA');
	else
		return('SESENTA Y '||unidades(substr(dece,2,1)));	
	end if;
elsif substr(dece,1,1)='7' then
	if dece='70' then
		return('SETENTA');
	else
		return('SETENTA Y '||unidades(substr(dece,2,1)));	
	end if;
elsif substr(dece,1,1)='8' then
	if dece='80' then
		return('OCHENTA');
	else
		return('OCHENTA Y '||unidades(substr(dece,2,1)));	
	end if;
elsif substr(dece,1,1)='9' then
	if dece='90' then
		return('NOVENTA');
	else
		return('NOVENTA Y '||unidades(substr(dece,2,1)));	
	end if;
else
		return unidades(substr(dece,2,1));	
end if;
 
end;
 
 
function centenas(cent in varchar2) return varchar2 is
begin 
 
if substr(cent,1,1)='1' then
	if cent='100' then
		return('CIEN');
	else
		return('CIENTO '||decenas(substr(cent,2,2)));	
	end if;
elsif substr(cent,1,1)='2' then
	if cent='200' then
		return('DOSCIENTOS');
	else
		return('DOSCIENTOS '||decenas(substr(cent,2,2)));	
	end if;
elsif substr(cent,1,1)='3' then
	if cent='300' then
		return('TRESCIENTOS');
	else
		return('TRESCIENTOS '||decenas(substr(cent,2,2)));	
	end if;
elsif substr(cent,1,1)='4' then
	if cent='400' then
		return('CUATROCIENTOS');
	else
		return('CUATROCIENTOS '||decenas(substr(cent,2,2)));	
	end if;
elsif substr(cent,1,1)='5' then
	if cent='500' then
		return('QUINIENTOS');
	else
		return('QUINIENTOS '||decenas(substr(cent,2,2)));	
	end if;
elsif substr(cent,1,1)='6' then
	if cent='600' then
		return('SEISCIENTOS');
	else
		return('SEISCIENTOS '||decenas(substr(cent,2,2)));	
	end if;
elsif substr(cent,1,1)='7' then
	if cent='700' then
		return('SETECIENTOS');
	else
		return('SETECIENTOS '||decenas(substr(cent,2,2)));	
	end if;
elsif substr(cent,1,1)='8' then
	if cent='800' then
		return('OCHOCIENTOS');
	else
		return('OCHOCIENTOS '||decenas(substr(cent,2,2)));	
	end if;
elsif substr(cent,1,1)='9' then
	if cent='900' then
		return('NOVECIENTOS');
	else
		return('NOVECIENTOS '||decenas(substr(cent,2,2)));	
	end if;
else
		return decenas(substr(cent,2,2));
end if;
end;
 
 
BEGIN
numeroch:=to_char(numero,'999999999999999D00');
numeroch:=lpad(ltrim(numeroch),20,'0');
centimos:=substr(numeroch,instr(numeroch,',')+1,2);
millares:=substr(numeroch,instr(numeroch,',')-3,3);
unimills:=substr(numeroch,instr(numeroch,',')-6,3);
unimilos:=substr(numeroch,instr(numeroch,',')-9,3);
unibilos:=substr(numeroch,instr(numeroch,',')-12,3);
resultado:=null;
resultado1:=null;
 
if decenas(centimos) is not null then --los centimos
	if decenas(centimos)='UN' then
		resultado1:=decenas(centimos)||' CENTIMO';
	else
		resultado1:=decenas(centimos)||' CENTIMOS';
	end if;
end if;
 
if centenas(millares) is not null then
	if resultado is not null then 
		resultado:='Y '||resultado;
	end if;
	if centenas(millares)='UN' then
		resultado:=centenas(millares)||' '||resultado;
	else
		resultado:=centenas(millares)||' '||resultado;
	end if;
end if;
 
if centenas(unimills) is not null then
	if resultado is not null then 
		resultado:=' '||resultado;
	end if;
        
	if centenas(unimills)='UN' then
		resultado:='UN '||resultado;
	else
		resultado:=centenas(unimills)||' '||resultado;
  end if;
end if;
 
if centenas(unimilos) is not null then
	if resultado is not null then 
		resultado:=' '||resultado;
	end if;
	if centenas(unimilos)='UN' then
		resultado:=centenas(unimilos)||' MIL '||resultado;
	else
		resultado:=centenas(unimilos)||' MIL '||resultado;
	end if;
end if;
if centenas(unibilos) is not null then
	if resultado is not null then 
		resultado:=' '||resultado;
	end if;
	if centenas(unibilos)='UN' then
		resultado:=centenas(unibilos)||' MILLON '||resultado;
	else
		resultado:=centenas(unibilos)||' MILLONES '||resultado;
	end if;
end if;
 
if resultado is not null then
   if resultado1 is not null then
      resultado1:='CON '||resultado1;
   end if;
   if substr(resultado,length(resultado)-5,6)='LONES' or substr(resultado,length(resultado)-5,6)='ILLON' then
      resultado:=resultado||'DE PESOS '||resultado1;
   else
       if resultado='UN' then
        		resultado:=resultado||'PESO ';
       else
	        	resultado:=resultado||'PESOS ';
	     end if;
   end if;
END if;
resultado:=resultado||resultado1;
 
return(NLS_UPPER(substr(resultado,1,1))||substr(resultado,2));
 
 
 
END;
/
 
