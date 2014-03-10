//
//  lda.h
//  PLDA
//
//  Created by Ben Blackburne on 06/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#ifndef PLDA_lda_h
#define PLDA_lda_h

#import "accumulative_model.h"

namespace learning_lda {
    LDAAccumulativeModel* LearnFromCorpus(std::vector<string> *lines,int num_topics,map<string, int>* word_index_map, int total_iterations, int burn_in_iterations, double alpha, double beta, string filename);
}


#endif
