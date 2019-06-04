"""Linear Softmax Classifier."""
# pylint: disable=invalid-name
import numpy as np

from .linear_classifier import LinearClassifier


def cross_entropoy_loss_naive(W, X, y, reg):
    """
    Cross-entropy loss function, naive implementation (with loops)

    Inputs have dimension D, there are C classes, and we operate on minibatches
    of N examples.

    Inputs:
    - W: A numpy array of shape (D, C) containing weights.
    - X: A numpy array of shape (N, D) containing a minibatch of data.
    - y: A numpy array of shape (N,) containing training labels; y[i] = c means
      that X[i] has label c, where 0 <= c < C.
    - reg: (float) regularization strength

    Returns a tuple of:
    - loss as single float
    - gradient with respect to weights W; an array of same shape as W
    """
    # pylint: disable=too-many-locals
    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)

    ############################################################################
    # TODO: Compute the cross-entropy loss and its gradient using explicit     #
    # loops. Store the loss in loss and the gradient in dW. If you are not     #
    # careful here, it is easy to run into numeric instability. Don't forget   #
    # the regularization!                                                      #
    ############################################################################

    ############################################################################
    #                          END OF YOUR CODE                                #
    ############################################################################
    
    
    A = np.dot(X, W)
    for i in range(y.shape[0]):
      ai = A[i]
      logC = np.max(ai)
      ai -= logC
      denom = np.sum(np.exp(ai))
      p = lambda k: np.exp(ai[k]) / denom
      loss += -np.log(p(y[i]))
      for k in range(W.shape[1]):
        pk = p(k)
        dW[:, k] += (pk - (k == y[i])) * X[i]
    
    loss = loss / y.shape[0]
    
    dW /= y.shape[0]
    dW += reg*W
    
    
    
    return loss, dW

    


def cross_entropoy_loss_vectorized(W, X, y, reg):
    """
    Cross-entropy loss function, vectorized version.

    Inputs and outputs are the same as in cross_entropoy_loss_naive.
    """
    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)

    ############################################################################
    # TODO: Compute the cross-entropy loss and its gradient without explicit   #
    # loops. Store the loss in loss and the gradient in dW. If you are not     #
    # careful here, it is easy to run into numeric instability. Don't forget   #
    # the regularization!                                                      #
    ############################################################################

    ############################################################################
    #                          END OF YOUR CODE                                #
    ############################################################################
    
    
    a = np.dot(X, W)
    logC = np.max(a, axis=1, keepdims=True)
    a -= logC
    denom = np.sum(np.exp(a), axis=1, keepdims=True)
    nom = np.exp(a)
    p = nom/denom
    loss = np.sum(-np.log(p[np.arange(y.shape[0]), y]))
    
    pind = np.zeros_like(p)
    pind[np.arange(y.shape[0]), y] = 1
    dW = X.T.dot(p - pind)
    
    loss = loss / y.shape[0]
    
    
    dW /= y.shape[0]
    dW += reg*W
    
    
    return loss, dW


class SoftmaxClassifier(LinearClassifier):
    """The softmax classifier which uses the cross-entropy loss."""

    def loss(self, X_batch, y_batch, reg):
        return cross_entropoy_loss_vectorized(self.W, X_batch, y_batch, reg)


def softmax_hyperparameter_tuning(X_train, y_train, X_val, y_val):
    # results is dictionary mapping tuples of the form
    # (learning_rate, regularization_strength) to tuples of the form
    # (training_accuracy, validation_accuracy). The accuracy is simply the
    # fraction of data points that are correctly classified.
    results = {}
    best_val = -1
    best_softmax = None
    all_classifiers = []
    learning_rates = [1e-7, 5e-7]
    regularization_strengths = [2.5e4, 5e4]

    ############################################################################
    # TODO:                                                                    #
    # Write code that chooses the best hyperparameters by tuning on the        #
    # validation set. For each combination of hyperparameters, train a         #
    # classifier on the training set, compute its accuracy on the training and #
    # validation sets, and  store these numbers in the results dictionary.     #
    # In addition, store the best validation accuracy in best_val and the      #
    # Softmax object that achieves this accuracy in best_softmax.              #                                      #
    #                                                                          #
    # Hint: You should use a small value for num_iters as you develop your     #
    # validation code so that the classifiers don't take much time to train;   # 
    # once you are confident that your validation code works, you should rerun #
    # the validation code with a larger value for num_iters.                   #
    ############################################################################

    ############################################################################
    #                              END OF YOUR CODE                            #
    ############################################################################
        
    num_iters = 1500
    for i in range(len(learning_rates)):
        for j in range(len(regularization_strengths)):
            lr = learning_rates[i]
            rs = regularization_strengths[j]
            softmax = SoftmaxClassifier()
            train = softmax.train(X_train, y_train, learning_rate = lr, reg = rs, num_iters = num_iters, verbose=True)
            y_train_predict = softmax.predict(X_train)
            acc_train = np.mean(y_train == y_train_predict)
            y_val_predict = softmax.predict(X_val)
            acc_val = np.mean(y_val == y_val_predict)
            results[(lr, rs)] = (acc_train, acc_val)
            if best_val < acc_val:
                best_val = acc_val
                best_softmax = softmax
        
        
    # Print out results.
    for (lr, reg) in sorted(results):
        train_accuracy, val_accuracy = results[(lr, reg)]
        print('lr %e reg %e train accuracy: %f val accuracy: %f' % (
              lr, reg, train_accuracy, val_accuracy))
        
    print('best validation accuracy achieved during validation: %f' % best_val)

    return best_softmax, results, all_classifiers
