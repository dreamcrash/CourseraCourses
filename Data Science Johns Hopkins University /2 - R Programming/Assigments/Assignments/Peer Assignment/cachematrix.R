## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

# Function to create a special type of matrix, a cacheable matrix
makeCacheMatrix <- function(x = matrix()) {
        inverse <- NULL                                   # This variable will hold the inverse matrix, but for now is being set to null,
                                                          # since the inverse of the matrix as not been calculated yet
        
        set <- function(y) {                              # This function set the value of vector
                x <<- y                                   # update the old matrix to the new matrix
                inverse <<- NULL                          # reset the inverse of the matrix of the new matrix.
        }
        get <- function() x                               # This function get the actual matrix
        setinverse <- function(solve) inverse <<- solve   # This function set the value of the inverse of the matrix
        getinverse <- function() inverse                  # This function get the inverse of the matrix
        list(set = set, get = get,                        # This list with the available functions
             setinverse = setinverse,
             getinverse = getinverse)
}


## Write a short comment describing this function

# The following function calculates the inverse of the special "matrix" created with the above function (makeCacheMatrix). 
# However, it first checks to see if the inverse of the matrix has already been calculated. 
# If so, it gets the inverse of the matrix from the cache and skips the computation. 
# Otherwise, it calculates the inverse of the matrix of the data and sets the value 
# of the inverse of the matrix in the cache via the setinverse function.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        inverse <- x$getinverse()                     # holds the inverse of the matrix
        if(!is.null(inverse)) {                       # check if this inverse of the matrix has been calculated
                message("getting cached data")        # if so, prints this message "getting cached data" and
                return(inverse)                       # returns the inverse of the matrix and skips the computation.
        }
        #If the inverse has not been calculated:
        data <- x$get()                               # get the actual matrix       
        inverse <- solve(data, ...)                   # calculating the inverse of the matrix using solve
        x$setinverse(inverse)                         # updating the variable that holds the inverse of the matrix
        inverse                                       
}
