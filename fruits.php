<? $fruits = array('banana', 'apple', 'orange') ?>
A sorted list of fruits:

<? sort($fruits) ?>
<? foreach ($fruits as $fruit) { ?>
  * <?= $fruit ?>

<? } ?>

<?= $fruits[0] ?> is spelled:
  <?= implode(' ', str_split($fruits[0])) ?>
<?
  $rubies = array(
    '1.8' => 'unsupported',
    '1.9' => 'supported',
    '2.0' => 'supported'
  )
?>


Important note regarding Ruby versions:

<? foreach ($rubies as $ruby => $status) { ?>
  * <?= implode(' is ', array($ruby, $status)) ?>

<? } ?>
