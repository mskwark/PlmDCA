#!/home/skwarkmj/sw/julia/julia

using ArgParse
using GaussDCA
using PlmDCA


function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "--gaps", "-g"
            help = "Fraction of gaps to use"
        "--di"
            help = "an option without argument, i.e. a flag"
            action = :store_true
        "arg1"
            help = "input alignment"
            required = true
        "arg2"
            help = "lambdaJ 0"
            required = true
        "arg3"  
            help = "Output file"
            required = true
    end

    return parse_args(s)
end

function main()
   parsed_args = parse_commandline()
   x = PlmDCA.plmdca(parsed_args["arg1"], lambdaJ=float(parsed_args["arg2"]))
   score=x.score
   Jtensor=x.Jtensor
   hvector=x.hvector

   io = open(parsed_args["arg3"], "w")
   for s in score
        @printf(io, "%d,%d,%f\n",s[1],s[2],s[3])
   end
   close(io)
  
   io = open(string(parsed_args["arg3"], ".Jtensor"), "w")
   N = size(Jtensor, 3)
   q = size(Jtensor, 1)
   for i = 1:N, j = 1:N
	@printf(io, "%d %d", i, j)
	for q1=1:q, q2=1:q
		@printf(io, " %f", Jtensor[q1,q2,i,j])
	end
	@printf(io, "\n")
   end
   close(io)
   io = open(string(parsed_args["arg3"], ".hvector"), "w")
   N = size(hvector, 2)
   q = size(Jtensor, 1)
   for i = 1:N
	@printf(io, "%d", i)
	for q1=1:q
		@printf(io, " %f", hvector[q1,i])
	end
	@printf(io, "\n")
   end
   close(io)
end
  

main()
