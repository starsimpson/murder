#!/usr/bin/perl

#Murder: Version .4.2
#Written by Star Simpson
#Last Update: 081604 14:00
#Latest Updates:  

#CL-version

use strict;
use vars qw($process);
    
$process = shift;
if ($process) {
        search($process);
    }    
    
else {
    print "What process?\n";
    $process=<STDIN>;
    chomp($process);
    search($process);
    }
    
sub search {
    my $keyword = $process;
    my @processes = `ps -acxww -o pid,command | grep -ie $keyword`;
    #print "@processes";
        if(@processes) {
            if(@processes > 1) {
                if(@processes[0] =~ /PID/) {
                    shift @processes;
                    }
                print "Ambiguous result.\n Please choose between:\n @processes";
                print "Enter a line number:\n";
                my $line = <STDIN>;
                chomp($line);
                $process = @processes[$line-1];
                assasinate($process);
            }
            elsif(@processes = 1) {
                $process = `ps -acxww -o pid,command | grep -ie $keyword`;
                assasinate($process);
            }
            else {
                die "Unknown result.\n";
            }
        }
        else {
            die "No matches\n";
        }
    }

sub assasinate {
#get name output
my $name = shift @_;
#Find the process, format, and strip off PID
$_ =  $name;
/(\d+)/;
#Commit the slaying
#chomp($name);
#print "$name was killed\n";
`kill -9 $1`;
}
