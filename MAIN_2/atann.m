function [ angle ] = atann( bb )
    angle = real( asin( complex(bb) ) );
end

