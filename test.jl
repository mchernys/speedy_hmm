function test_chimera_probs(probs)
    # answer key from commit bc8a58bab539534e8e7845ca0798a6e82c432f0d, prior to optimization attempts 
    true_probs = CSV.read("chimera_probs_10k_IGH_sim.tsv", DataFrame).Probability[1:length(probs)]
    if all(isapprox.(true_probs, probs))
        @info "PASS CHIMERA PROBS 👍"
    else
        @info "FAIL CHIMERA PROBS 👎"
    end
end

function test_chimera_recombs(recombs)
    true_recombs_pathevals = CSV.read("chimera_recombs_10k_IGH_sim.tsv", DataFrame).Recombinations[1:length(recombs)]
    recomb_strs = [split("$(el)", "pathevaluation")[1] for el in recombs]
    true_recombs = [split(el, "pathevaluation")[1] for el in true_recombs_pathevals]
    true_pathevaluations = parse.(Float64, [split(s, "=")[end][1:end-1] for s in true_recombs_pathevals])
    pathevaluations = [el.pathevaluation for el in recombs]
    if all(recomb_strs .== true_recombs) & all(isapprox.(true_pathevaluations, pathevaluations))
        @info "PASS CHIMERA RECOMBS 👍"
    else
        @info "FAIL CHIMERA RECOMBS 👎"
    end
end