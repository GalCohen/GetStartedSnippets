describe('filter', function  () {
    beforeEach(module('myApp'));

    describe('reverse', function  () {
        it('Should reverse a string', inject(function (reverse) {
            expect(reverseFilter('ABCD').toEqual('DCBA');
            expect(reverseFilter('John').toEqual('nhoJ');
        }));
    })
});