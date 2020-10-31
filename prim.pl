# Eratosthenes' Sieve 
# a visual, minimally numerical method  
# third line in github
# fourth line local

$MAX = 4;

init();
prstep();

while (++$i <= $MAX) {

  # new p: first two steps are direct old p plus 1 -- pattern is too short 
  # 
  $n = $p[$i-1] + 1;
  $p[$i] = $n > $size ?  $n : p_next(); 

  # Replicate pattern times p:
  #
  @{$pattern[$i]} = ( @{$pattern[$i-1]} ) x $p[$i];

  $size = scalar @{$pattern[$i]}; 

  # Sieve each p'th element
  #
  $sieved = 0;
  for ( $j =  $p[$i]-1; $j <= $size; $j += $p[$i] ) {

        if ($pattern[$i][$j] eq 'x') {

            $pattern[$i][$j] =  '.'; 
	    $sieved++;
#				printf "S: %5d\t", $j+1;
        }
  }
  # print this step
  prstep();
}

#########

sub p_next {
  # this is the next 'x' after old p[i], for steps > 2
  #
  until($pattern[$i-1][$n-1] eq 'x') {
    $n++;
  } 
  return $n;
} 

sub prstep {
  # print pattern and other per-step variables 
  #
  print "\nsieved:$sieved (Step=$i), p=$p[$i], len=$size\n";
  print @{$pattern[$i]}, "\n"; 
  # or:
  # pr_block();
  return;
}

sub pr_block {
  # print pattern aligned in p lines 
  #
  $s = $size/$p[$i];
  print "$s\n";
  for ($k=0; $k<$size; $k+=$s) {
    print @{$pattern[$i]}[$k .. $k+$s-1], "\n";
  } 
  return;
}


sub init {
  # "$i" is index/step
  #
  $i      = 0; 
  $p[$i]  = 1;

  @{$pattern[$i]} = ('x'); 

  $size = 1;
}
