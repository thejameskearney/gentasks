use strict;
use warnings;

sub main {

  our $^I = '.bak';

  my $fg = $ARGV[0] . '/*.md';

  while ( my $file = glob($fg) ) {

    print "Processing $file\n";

    our @ARGV = ($file);
    my $incr = 0;
    my $taskId;

    while ( <ARGV> ) {
      my $taskBlock = $_;
      if ( $taskBlock =~ /\[\s*\]/ ) {
        $incr = $incr + 1;
        $taskId = getTaskId("TSK", $incr);
        if ( $taskBlock =~ s/\[\s+\]/\[ $taskId \]/ ) {
          print $taskBlock;
        }
      } else {
        print;
      }
    }
  }

}

sub getTaskId {
  my ($taskPrefix, $incr) = @_;

  my $taskId = $taskPrefix . "-" . time() . $incr;
  warn $taskId;
  return $taskId;
}

main();