//
//  infer.h
//  PLDA
//
//  Created by Ben Blackburne on 07/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#ifndef PLDA_infer_h
#define PLDA_infer_h


int infer(learning_lda::LDAModel &model, std::map<string,int> &word_index_map, std::vector<string> &bag_of_words, double alpha, double beta, int iterations, int burn_in, std::vector<std::vector<double> > &ans);

int infer(string model_path, std::vector<string> &bag_of_words, double alpha, double beta, int iterations, int burn_in, std::vector<std::vector<double> >&ans);
#endif
