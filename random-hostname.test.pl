use diagnostics;
use warnings;
use strict;
use Test::More qw( no_plan );

do 'random-hostname.pl';

my @shortWordList = ("alpha # used by test\n", "beta\n");
my @wordlist = ("alpha\n", "beta\n", "charlie\n", "delta\n");
my @overlappingWordlist = ("partial\n", "tart\n", "smart\n", "start\n", "art\n");

# Get user test
chomp(my $user = `whoami`);
is (getUser(), $user, 'Should get the current user.');

# Get date test
chomp(my $date = `date +'%F %T'`);
$date =~ /(\d+-\d+\d+\ \d+\:\d+)/;
ok (getDate() =~ /$date/, 'Should return current date/time.');

# Get number of unused words test
my $availableWords = getNumberOfUnusedWords(@shortWordList);
is ($availableWords, 1, 'Should return correct number of available words.');

# Get available words test
my @availableWord = getAvailableWords(@shortWordList);
chomp $availableWord[0];
is ($availableWord[0], 'beta', 'Should return an unused word.');

# Get random word test
my $randomWord = getRandomWordFromArray(@wordlist);
ok ($randomWord =~ /alpha|beta|charlie|delta/, 'Should return a random word');

# Get word index test
my $index = getIndexOfWord($overlappingWordlist[4], @overlappingWordlist);
is ($index, 4, 'Should return correct location of word.');

# Set word used test
my @usedWordList = setWordAsUsed($wordlist[2], @wordlist);
ok ($usedWordList[2] =~ /# used by/, 'Should mark a word as used.');

