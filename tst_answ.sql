create or replace function f_min_to_max(arr int[], new_val int)
returns int[]
    as $$
    DECLARE
        r int[];
    begin
        r = array_append(arr, new_val);
        

        return r;
    end;
    $$ language plpgsql;



create or replace function f_min_to_max_2(arr int[])
returns text
    as $$
    DECLARE
        least_s int;
        greatest_s int;
    begin
        
        least_s =  (select min(t) from unnest(arr) as t);
        greatest_s = (select max(t) from unnest(arr) as t);
        
        return  least_s::text  ' -> '  greatest_s::text;
    end;
    $$ language plpgsql;


create aggregate min_to_max(int)
(
    INITCOND = '{}',
    sfunc = f_min_to_max,
    stype = int[],
    finalfunc = f_min_to_max_2
    );
    
    /*
    I newer used C - langiage, but i read about mask-type "internal" in custom aggregate.
    We also can swap int-type to anyarray, and include READ_WRITE options to FINALFUNC_MODIFY
    */
