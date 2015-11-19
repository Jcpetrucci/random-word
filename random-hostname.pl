#!/usr/bin/perl
use File::Basename;
use strict;
use warnings;
use diagnostics;

my $dirname = dirname(__FILE__); # Find path where this script lives

my $filename = $dirname . '/wordlist.txt'; # Open wordlist relative to script location.
my @wordlist = readFile($filename);
my $numberOfWordsAvailable = getNumberOfUnusedWords(@wordlist);
my @wordsAvailable = getAvailableWords(@wordlist);

if ($numberOfWordsAvailable == '0') { 
    print "Unable to find an available random word.\n";
    exit 1;
} else {
    my $word = getRandomWordFromArray(@wordsAvailable);
    @wordlist = setWordAsUsed($word, @wordlist);

    print "Your random word is: $word\n";

    writeFile($filename, @wordlist);
}

sub getUser {
    my $user = `whoami`;
    chomp($user);
    return $user;
}

sub getDate {
    my $date = `date +'%F %T'`;
    chomp($date);
    return $date;
}

sub getAvailableWords {
    my @unfilteredFile = @_;
    my @availableWords = grep not(/# used by/), @unfilteredFile;
    return @availableWords;
}

sub getNumberOfUnusedWords {
    my @unfilteredFile = @_;
    my @availableWords = getAvailableWords(@unfilteredFile);
    my $numberOfWordsAvailable = scalar @availableWords;
    return $numberOfWordsAvailable;
}

sub getRandomWordFromArray {
    #Find random number between 0 and length of 
    my @arrayOfWords = @_;
    my $randomNumber = int rand(scalar @arrayOfWords);
    my $randomWord = $arrayOfWords[$randomNumber];
    chomp($randomWord);
    return $randomWord;
}

sub getIndexOfWord {
    my ($searchWord, @wordArray) = @_;
    my ($index) = grep { $wordArray[$_] =~ "^$searchWord\$" } 0 .. $#wordArray;
    return $index;
}

sub setWordAsUsed {
    my ($word, @unfilteredWordList) = @_;
    my $user = getUser();
    my $date = getDate();
    my $wordLocation = getIndexOfWord($word, @unfilteredWordList);
    $unfilteredWordList[$wordLocation] = "$word # used by $user at $date\n"; 
    return @unfilteredWordList;
}

sub readFile {
    my $filename = shift;
    my @file;
    open FILE, "<$filename" or die "Error opening $filename!";
    @file = <FILE>;
    close FILE;
    return @file;
}

sub writeFile {
    my ($filename, @fileToWrite) = @_;
    open FILE, ">$filename" or die "Error opening $filename for writing!";
    print FILE @fileToWrite;
    close FILE;
}
