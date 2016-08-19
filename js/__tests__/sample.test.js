import test from 'ava';
import {sum, product} from '../sample'

test('sample.js: should pass the framework setup tests', (t) => {
  t.is(2 + 2, 4)
})

test('sample.js: sum - should add 2 numbers', (t) => {
  console.log(sum)
  t.is(sum(3, 5), 8);
})

test('sample.js: product - should multiply 2 numbers', (t) => {
  t.is(product(3, 5), 15);
})
