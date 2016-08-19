import test from 'ava';
import {sum, product} from '../sample'

test('sample.js: sum - should add 2 numbers', (t) => {
  t.is(sum(3, 5), 8);
})

test('sample.js: product - should multiply 2 numbers', (t) => {
  t.is(product(3, 5), 15);
})
